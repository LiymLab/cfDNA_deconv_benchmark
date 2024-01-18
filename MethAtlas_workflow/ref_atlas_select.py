#!/usr/bin/env python3
# Author: Tongyue Sun

import os
import pandas as pd
import subprocess
import shutil
import numpy as np


# nohup python ref_atlas_select.py > ref_atlas_select.log 2>&1 &


def read_and_process_files(file_list, output_dir, chrX_indices):
    # Initialize an empty DataFrame to store methylation ratios
    all_covered = pd.DataFrame()

    # Iterate through the file list
    for file_path in file_list:
        # Construct the full file path
        file_path = os.path.join(output_dir, file_path)

        # Read the file content
        content = np.fromfile(file_path, dtype=np.uint8).reshape((-1, 2))

        # Calculate the methylation ratio
        meth_ratio = content[:, 0] / content[:, 1]

        # Get the file name (without extension) as the column name
        file_name = os.path.splitext(os.path.basename(file_path))[0]

        # Add the methylation ratio as a column in the DataFrame
        all_covered[file_name] = meth_ratio

    # Reindex the DataFrame, add 'cpg_idx' column, and remove the old index
    all_covered = (
        all_covered.reset_index()
        .assign(cpg_idx=lambda x: x["index"] + 1)
        .drop("index", axis=1)
    )

    # Move the 'cpg_idx' column to the beginning
    last_col = all_covered.pop("cpg_idx")
    all_covered.insert(0, "cpg_idx", last_col)

    # Set the variance threshold
    var_threshold = 0.001

    # Filter the DataFrame based on the variance threshold and remove NaN values
    all_covered_var = all_covered.loc[
        all_covered.iloc[:, 1:].var(axis=1) >= var_threshold
    ].dropna()

    # drop sex Chr 
    drop_indices = all_covered_var[all_covered_var["cpg_idx"].isin(chrX_indices)].index

    # Drop the rows from ref_df based on the identified indices
    all_covered_var = all_covered_var.drop(drop_indices)
    # Return the filtered DataFrame
    return all_covered_var


def filter_depth(file_list, ref_df, depth_filter, folder_path):
    # Initialize a DataFrame 
    all_covered = pd.DataFrame()

    # Iterate through the file list
    for file_name in file_list:
        # Construct the full file path
        file_path = os.path.join(folder_path, file_name)

        # Read the file content
        content = np.fromfile(file_path, dtype=np.uint8).reshape((-1, 2))

        # Extract the coverage data
        covered = content[:, 1]

        # Add the coverage data as a column in the DataFrame
        all_covered[file_name] = covered

    # Calculate the median coverage per row
    row_median = all_covered.median(axis=1)

    # Identify the indices where median coverage is less than the depth filter
    filtered_indices = row_median[row_median < depth_filter].index

    # Create a DataFrame containing the filtered indices
    result_df = pd.DataFrame({"cpg_idx": filtered_indices})

    # Adjust the 'cpg_idx' values
    result_df["cpg_idx"] = result_df["cpg_idx"] + 1

    # Identify the indices in ref_df that need to be dropped
    drop_indices = ref_df[ref_df["cpg_idx"].isin(result_df["cpg_idx"])].index

    # Drop the rows from ref_df based on the identified indices
    new_ref_df = ref_df.drop(drop_indices)

    # Return the updated reference DataFrame
    return new_ref_df


def filter_and_normalize_data(all_covered_var, K, output_dir):
    normalized_data = all_covered_var.copy()
    normalized_data.iloc[:, 1:] = normalized_data.iloc[:, 1:].div(
        normalized_data.iloc[:, 1:].sum(axis=1), axis=0
    )

    hypermethylated_cpgs = pd.DataFrame()
    for cell_type in normalized_data.columns[1:]:
        sorted_cpgs = normalized_data.sort_values(by=cell_type, ascending=False)
        hypermethylated_cpgs = pd.concat([hypermethylated_cpgs, sorted_cpgs.head(K)])

    filtered_data = all_covered_var.copy()
    filtered_data.iloc[:, 1:] = 1 - filtered_data.iloc[:, 1:].values
    normalized_data = filtered_data.copy()
    normalized_data.iloc[:, 1:] = normalized_data.iloc[:, 1:].div(
        normalized_data.iloc[:, 1:].sum(axis=1), axis=0
    )

    unmethylated_cpgs = pd.DataFrame()
    for cell_type in normalized_data.columns[1:]:
        sorted_cpgs = normalized_data.sort_values(by=cell_type, ascending=False)
        unmethylated_cpgs = pd.concat([unmethylated_cpgs, sorted_cpgs.head(K)])

    merged_df = pd.concat(
        [hypermethylated_cpgs[["cpg_idx"]], unmethylated_cpgs[["cpg_idx"]]]
    )
    merged_df = merged_df.drop_duplicates()
    output_file = os.path.join(output_dir, "top_cpgs.csv")
    merged_df.to_csv(output_file, index=False)
    return merged_df


def merge_and_filter_cpgs(all_covered_var, illumina_df, output_dir="full_var_cpgs.bed"):
    # top_cpgs.bed generate
    top_file = os.path.join(output_dir, "top_cpgs.csv")
    top_filtered = pd.read_csv(top_file)
    top_overlap_values = top_filtered["cpg_idx"].values
    top_filtered_df = illumina_df[illumina_df["cpg_idx"].isin(top_overlap_values)]
    top_out = os.path.join(output_dir, "top_cpgs.bed")
    top_filtered_df.to_csv(top_out, sep="\t", index=False, header=None)
    # full generate
    overlap_values = all_covered_var["cpg_idx"].values
    filtered_df = illumina_df[illumina_df["cpg_idx"].isin(overlap_values)]
    output_file = os.path.join(output_dir, "full_var_cpgs.bed")
    filtered_df.to_csv(output_file, sep="\t", index=False, header=None)


# def run_bedtools_commands(output_dir):#input_file1='top_cpgs.bed', input_file2='full_var_cpgs.bed',
# output_dir='top_cpgs_lr50.bed'):


def run_bedtools_commands(output_dir):
    input_file1 = os.path.join(output_dir, "top_cpgs.bed")
    input_file2 = os.path.join(output_dir, "full_var_cpgs.bed")
    output_file = os.path.join(output_dir, "top_cpgs_lr50.bed")
    command_t = (
        f"bedtools window -a {input_file1} -b {input_file2} -l 50 -r 50 > {output_file}"
    )
    process = subprocess.Popen(command_t, shell=True)
    process.wait()


def run_awk_command(
    output_dir,
):  # input_file='top_cpgs_lr50.bed', output_dir='overlapped_cpg.bed'):
    input_file = os.path.join(output_dir, "top_cpgs_lr50.bed")
    output_file = os.path.join(output_dir, "overlapped_cpg.bed")
    command_awk = f"awk '{{print $NF}}' {input_file} > {output_file}"
    process = subprocess.Popen(command_awk, shell=True)
    process.wait()


def extend_and_filter_cpgs(
    concat_df, full_atlas_df, output_dir, depth
):  # ='ref_unique_lr50.csv'):
    overlapped_df = concat_df.copy()
    filtered_full_atlas_df = full_atlas_df[
        ~full_atlas_df["cpg_idx"].isin(overlapped_df["cpg_idx"])
    ]
    reference_df = overlapped_df.copy()

    cell_types = reference_df.columns[1:].tolist()
    for _ in range(500):
        min_distance = float("inf")
        closest_pair = None

        for i in range(len(cell_types)):
            for j in range(i + 1, len(cell_types)):
                cell_type_i = cell_types[i]
                cell_type_j = cell_types[j]
                dist = np.linalg.norm(
                    reference_df[cell_type_i] - reference_df[cell_type_j]
                )
                if dist < min_distance:
                    min_distance = dist
                    closest_pair = (cell_type_i, cell_type_j)

        cell_type_1, cell_type_2 = closest_pair
        diff_column = np.abs(
            filtered_full_atlas_df[cell_type_1] - filtered_full_atlas_df[cell_type_2]
        )
        max_diff_index = diff_column.idxmax()
        max_diff_row = filtered_full_atlas_df.loc[max_diff_index]

        reference_df = reference_df.append(max_diff_row)
        filtered_full_atlas_df = filtered_full_atlas_df[
            ~filtered_full_atlas_df["cpg_idx"].isin([max_diff_row["cpg_idx"]])
        ]

    reference_unique_df = reference_df.drop_duplicates(subset="cpg_idx")
    # reference_unique_df.to_csv(output_file, index=False)
    # ...
    output_file = os.path.join(output_dir, f"ref_depth_{depth}_unique.csv")
    reference_unique_df.to_csv(output_file, index=False)


def main():
    depth_fliter = [15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100]
    for depth in depth_fliter:
        input_dir = "/home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref"
        output_dir = f"/home/sty/cfDNA_benchmark/meth_atlas_data/ref_median_{depth}/"
        id_list = pd.read_csv(
            f"~/cfDNA_benchmark/benchmark_pat/crd_dis/crd_dis.csv"
        )["ID"].to_list()

        file_list = [f + ".hg38.beta" for f in id_list]
        file_list.sort()

        # Copy files
        for file_name in file_list:
            input_file = os.path.join(input_dir, file_name)
            output_file = os.path.join(output_dir, file_name)
            shutil.copy(input_file, output_file)
        # Read hg38.bed file
        illumina_df = pd.read_table("/home/sty/bed_hg38/bed_hg38.bed", header=None)
        illumina_df.columns = ["chrom", "start", "end", "cpg_idx"]
        # Filter sex chr
        chrX_indices = illumina_df[illumina_df['chrom'].isin(['chrX', 'chrY'])]['cpg_idx']

        # Process files
        all_covered_var = read_and_process_files(file_list, output_dir, chrX_indices)
        # Depth filter
        all_covered_var = filter_depth(file_list, all_covered_var, depth, output_dir)


        # Filter and normalize data, get top K markers.
        merged_df = filter_and_normalize_data(
            all_covered_var, K=100, output_dir=output_dir
        )

        # Merge and filter CpGs
        merge_and_filter_cpgs(all_covered_var, illumina_df, output_dir=output_dir)

        # Run bedtools commands
        run_bedtools_commands(output_dir=output_dir)

        # Run awk command
        run_awk_command(output_dir=output_dir)

        # Extend and filter CpGs
        df_unique = pd.read_csv(
            os.path.join(output_dir, "overlapped_cpg.bed"), sep="\t"
        )
        df_unique.columns = ["cpg_idx"]
        concat_df = pd.merge(all_covered_var, df_unique, on="cpg_idx")
        extend_and_filter_cpgs(concat_df, all_covered_var, output_dir=output_dir,depth = depth)


if __name__ == "__main__":
    main()


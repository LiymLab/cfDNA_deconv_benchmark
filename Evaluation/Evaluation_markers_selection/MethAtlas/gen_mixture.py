import os
import pandas as pd
import subprocess
import shutil
import numpy as np
import glob

def read_and_process_files(file_list, output_dir,ref_df):
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
    all_covered = all_covered[all_covered['cpg_idx'].isin(ref_df['cpg_idx'])]
    all_covered.to_csv(f'{output_dir}/full_atlas.csv',index = False)
    return None

for i in [15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100]:
    ref_df = pd.read_csv(f'/cfDNA_benchmark/meth_atlas_data/ref_median_{i}/ref_depth_{i}_unique.csv')
    input_dir = f"/cfDNA_benchmark/benchmark_pat/pat_merged/mix"
    output_dir = f"/cfDNA_benchmark/meth_atlas_data/uniform/ref_median_{i}"
    file_extension = "*.beta"
    file_list = glob.glob(os.path.join(input_dir, file_extension))
    file_list.sort()
    illumina_df = pd.read_table("/bed_hg38/bed_hg38.bed", header=None)
    illumina_df.columns = ["chrom", "start", "end", "cpg_idx"]

    # Process files
    all_covered_var = read_and_process_files(file_list, output_dir, ref_df)
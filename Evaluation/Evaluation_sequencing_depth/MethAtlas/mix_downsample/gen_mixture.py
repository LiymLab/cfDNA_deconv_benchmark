import numpy as np
import pandas as pd
import os
import re
from concurrent.futures import ThreadPoolExecutor, as_completed

median_range = [15]
ref_folder = f"~/meth_atlas"
mixture_folder = f"~mix_pat/downsample"

subfolders_to_process = ["dirichlet", "uniform", "crd"]
sub_nums = [1, 5, 10, 15]


def extract_number(col_name):
    match = re.search(r"_(\d+)_", col_name)
    if match:
        return int(match.group(1))
    return float("inf")


def process_subfolder_sub_num(subfolder, sub_num):
    median_value = 15
    out_path = f"{ref_folder}/mix_downsample"
    if not os.path.exists(out_path):
        os.makedirs(out_path)

    ref_file = os.path.join(ref_folder, f"reference_overlapped_midean_15_unique.csv")
    ref_df = pd.read_csv(ref_file)

    result_df = pd.DataFrame()

    mixture_folder_path = f"~/downsample/dirichlet/{subfolder}_{sub_num}"
    beta_files = os.listdir(mixture_folder_path)
    beta_files = sorted(beta_files)

    cpg_idx_values = ref_df["cpg_idx"]
    new_df = pd.DataFrame({"cpg_idx": cpg_idx_values})
    new_df["cpg_idx"] = new_df["cpg_idx"].astype("int")

    for beta_file in beta_files:
        if beta_file.endswith(".beta"):
            beta_path = os.path.join(mixture_folder_path, beta_file)
            beta_content = np.fromfile(beta_path, dtype=np.uint8).reshape((-1, 2))

            cpg_idx = new_df["cpg_idx"] - 1
            meth = beta_content[cpg_idx, 0]
            covered = beta_content[cpg_idx, 1]
            meth_ratio = meth / covered

            column_name = os.path.splitext(beta_file)[0]
            if "dirichle_" in column_name:
                column_name = column_name.replace("dirichle_", "dirichlet_")
            result_df[column_name] = meth_ratio

    output_df = pd.concat([new_df, result_df], axis=1)
    output_file = f"{out_path}/full_atlas_{subfolder}_0.5_{sub_num}.csv"
    columns_to_sort = output_df.columns[1:]
    sorted_columns = sorted(columns_to_sort, key=extract_number)
    output_df = output_df[[output_df.columns[0]] + sorted_columns]
    output_df.to_csv(output_file, index=False)
    del ref_df, result_df, new_df


with ThreadPoolExecutor(max_workers=12) as executor:
    futures = []
    for subfolder in subfolders_to_process:
        for sub_num in sub_nums:
            futures.append(
                executor.submit(process_subfolder_sub_num, subfolder, sub_num)
            )

    for future in as_completed(futures):
        try:
            future.result()
        except Exception as e:
            print(f"An error occurred: {e}")

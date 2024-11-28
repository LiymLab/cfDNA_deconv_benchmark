import os
import pandas as pd
import subprocess
import shutil
import numpy as np
import glob


def read_and_process_files(file_list, output_dir, ref_df):
    all_covered = pd.DataFrame()

    for file_path in file_list:
        file_path = os.path.join(output_dir, file_path)
        content = np.fromfile(file_path, dtype=np.uint8).reshape((-1, 2))
        meth_ratio = content[:, 0] / content[:, 1]
        file_name = os.path.splitext(os.path.basename(file_path))[0]
        all_covered[file_name] = meth_ratio

    all_covered = (
        all_covered.reset_index()
        .assign(cpg_idx=lambda x: x["index"] + 1)
        .drop("index", axis=1)
    )

    last_col = all_covered.pop("cpg_idx")
    all_covered.insert(0, "cpg_idx", last_col)
    all_covered = all_covered[all_covered["cpg_idx"].isin(ref_df["cpg_idx"])]

    all_covered["cpg_idx"] = all_covered["cpg_idx"].astype(int)

    all_covered.to_csv(f"{output_dir}/full_atlas.csv", index=False)
    return None


for dist in ["crd", "uniform", "dirichlet"]:
    for i in np.concatenate(
        [np.arange(15, 51, 5), np.arange(60, 101, 10), np.arange(100, 251, 50)]
    ):
        ref_df = pd.read_csv(
            f"/cfDNA_benchmark/meth_atlas_data/ref_median_{i}/ref_depth_{i}_unique.csv"
        )
        input_dir = f"/cfDNA_benchmark/benchmark_pat/pat_merged/mix/{dist}"
        output_dir = f"/cfDNA_benchmark/meth_atlas_data/{dist}/ref_median_{i}"
        file_extension = "*.beta"
        file_list = glob.glob(os.path.join(input_dir, file_extension))
        file_list.sort()
        illumina_df = pd.read_table("/bed_hg38/bed_hg38.bed", header=None)
        illumina_df.columns = ["chrom", "start", "end", "cpg_idx"]

        all_covered_var = read_and_process_files(file_list, output_dir, ref_df)

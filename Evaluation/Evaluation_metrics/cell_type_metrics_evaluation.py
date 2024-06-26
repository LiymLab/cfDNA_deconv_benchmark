import os
import pandas as pd
import numpy as np
from sklearn.metrics import mean_squared_error
from scipy.stats import pearsonr

results = "/results_folder" #deconvolution result

files = [
    os.path.join(results, f)
    for f in os.listdir(results)
    if f.startswith("start_word") and f.endswith("end_word")
]
files.sort()

def calculate_row_metrics(data1_df, data2_df, id_series):
    rmse_values = []
    pearson_values = []

    for i in range(data1_df.shape[0]):
        row1 = data1_df.iloc[i]
        row2 = data2_df.iloc[i]
        row_id = id_series.iloc[i]
        rmse = np.sqrt(mean_squared_error(row1, row2))
        rmse_values.append((row_id, rmse))

        p_correlation, _ = pearsonr(row1, row2)
        pearson_values.append((row_id, p_correlation))

    return rmse_values, pearson_values

for f in files:
    # get name
    new_name = f.split("split_words")[0].split("split_words")[1]

    # cfsort_dis path : '/home/sty/cfDNA_benchmark/benchmark_pat/cfsort_dis/cfsort_dis.csv'
    # uniform_dis path: '/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv'
    df2 = pd.read_csv(f)
    df_dis = pd.read_csv(
        "/silico_cfDNA_mixtures_path"
    )

    df1 = df_dis[df_dis["ID"].isin(df2[df2.columns[0]])]
    df1_id_column = df1["ID"]
    sorted_columns = sorted(df2.columns[1:], key=lambda x: int(x))
    df2 = df2.iloc[0:, 1:]
    sorted_df2 = df2[sorted_columns] 
    sorted_df2

    data1 = df1.iloc[0:, 1:]
    data2 = sorted_df2.iloc[0:, 0:]

    rmse_values, pearson_values = calculate_row_metrics(data1, data2, df1_id_column)

    rmse_df = pd.DataFrame(rmse_values, columns=["Row", "RMSE"])

    pearson_df = pd.DataFrame(pearson_values, columns=["Row", "Pearson Correlation"])

    # print(rmse_df)
    rmse_df.to_csv(f"target_folder/rmse_{new_name}.csv", index=False)

    # print(pearson_df)
    pearson_df.to_csv(f"target_folder/pearson_{new_name}.csv", index=False)

    del df1, df2, rmse_df, pearson_df

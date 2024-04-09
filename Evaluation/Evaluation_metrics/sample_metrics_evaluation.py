import os
import pandas as pd
import numpy as np

from sklearn.metrics import mean_squared_error
from scipy.stats import pearsonr
from scipy.stats import spearmanr

#results path
base_path = '/results_folder'
files = [os.path.join(base_path, f) for f in os.listdir(base_path) if f.startswith('start_word') and f.endswith('end_word')]
files.sort()

#cal values method
def calculate_metrics(data1, data2):
    rmse_values = []
    pearson_values = []
    spearman_values = []

    for i in range(data1.shape[1]):
        column = df1.columns[i+1]
        rmse = np.sqrt(mean_squared_error(data1[:, i], data2[:, i]))
        rmse_values.append((column, rmse))

        p_correlation, _ = pearsonr(data1[:, i], data2[:, i])
        pearson_values.append((column, p_correlation))

        s_correlation, _ = spearmanr(data1[:, i], data2[:, i])
        spearman_values.append((column, s_correlation))

    return rmse_values, pearson_values, spearman_values

# run the cal
for f in files:
    # cfsort_dis path : '/home/sty/cfDNA_benchmark/benchmark_pat/cfsort_dis/cfsort_dis.csv'
    # uniform_dis path: '/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv'
    df_dis = pd.read_csv('/silico_cfDNA_mixtures_path')
    df2 = pd.read_csv(f)
    df1 = df_dis[df_dis['ID'].isin(df2[df2.columns[0]])]
    
    sorted_columns = sorted(df2.columns[1:], key=lambda x: int(x.split('_')[-2]))
    df2 = df2.iloc[0: ,1:]
    sorted_df2 = df2[sorted_columns] 
    sorted_df2

    data1 = df1.iloc[0:, 1:].values.astype(float)
    data2 = sorted_df2.iloc[0:, 0:].values.astype(float)

    rmse_values, pearson_values, spearman_values = calculate_metrics(data1, data2)

    rmse_df = pd.DataFrame(rmse_values, columns=['Column', 'RMSE'])

    pearson_df = pd.DataFrame(pearson_values, columns=['Column', 'Pearson Correlation'])

    spearman_df = pd.DataFrame(spearman_values, columns=['Column', 'Spearman Correlation'])

    # print(rmse_df)
    rmse_df.to_csv(f"/save/path/filename", index=False)

    # print(pearson_df)
    pearson_df.to_csv(f"/save/path/filename", index=False)

    del df1, df2, data1, data2, rmse_df, pearson_df, spearman_df
import os
import pandas as pd
import numpy as np

from sklearn.metrics import mean_squared_error
from scipy.stats import pearsonr
from scipy.stats import spearmanr

#results path
base_path = '/drop/path/'
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
    # 读取 matrix_d.csv 文件
    # cfsort_dis path : '/home/sty/cfDNA_benchmark/benchmark_pat/cfsort_dis/cfsort_dis.csv'
    # uniform_dis path: '/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv'
    df_dis = pd.read_csv('/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv')
    # 读取 data.csv 文件
    df2 = pd.read_csv(f)
    #匹配列（if drop）
    df1 = df_dis[df_dis['ID'].isin(df2[df2.columns[0]])]
    #提取 df2 除一列之外的列数据
    
    # 按照 cfsort_dis_{01-100}_1 sort 数据
    sorted_columns = sorted(df2.columns[1:], key=lambda x: int(x.split('_')[-2]))
    df2 = df2.iloc[0: ,1:]
    sorted_df2 = df2[sorted_columns] # 将排序后的列应用到新的数据框
    sorted_df2

    # 提取需要比较的数据
    data1 = df1.iloc[0:, 1:].values.astype(float)
    data2 = sorted_df2.iloc[0:, 0:].values.astype(float)

    # 计算 RMSE、Pearson 相关系数和 Spearman 相关系数
    rmse_values, pearson_values, spearman_values = calculate_metrics(data1, data2)

    # 创建包含 RMSE 值的数据框
    rmse_df = pd.DataFrame(rmse_values, columns=['Column', 'RMSE'])

    # 创建包含 Pearson 相关系数的数据框
    pearson_df = pd.DataFrame(pearson_values, columns=['Column', 'Pearson Correlation'])
    
    # 创建包含 Spearman 相关系数的数据框
    spearman_df = pd.DataFrame(spearman_values, columns=['Column', 'Spearman Correlation'])
    
    # RMSE 值
    # print(rmse_df)
    rmse_df.to_csv(f"/save/path/filename", index=False)

    # Pearson 相关系数
    # print(pearson_df)
    pearson_df.to_csv(f"/save/path/filename", index=False)
    
    # Spearman 相关系数
    # print(spearman_df)
    spearman_df.to_csv(f"/save/path/filename", index=False)

    # 释放内存
    del df1, df2, data1, data2, rmse_df, pearson_df, spearman_df
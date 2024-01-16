import pandas as pd
import numpy as np
from sklearn.metrics import mean_squared_error
from scipy.stats import pearsonr
import sys

tissue_proportions = sys.argv[1]
rmse_output = sys.argv[2]
pearson_output = sys.argv[3]

# 读取 uniform_matrix_d.csv 文件
df1 = pd.read_csv('/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv')

# 读取 sorted_full_atlas_unifor_median_deconv_output.csv 文件
df2 = pd.read_csv(tissue_proportions)

# 提取需要比较的数据
data1 = df1.iloc[0:, 1:].values.astype(float)
data2 = df2.iloc[0:, 1:].values.astype(float)

# 计算 RMSE 值
rmse_values = []
for i in range(data1.shape[1]):
    column = df1.columns[i+1]
    rmse = np.sqrt(mean_squared_error(data1[:, i], data2[:, i]))
    rmse_values.append((column, rmse))

# 创建包含 RMSE 值的数据框
rmse_df = pd.DataFrame(rmse_values, columns=['Column', 'RMSE'])

# 计算 Pearson 相关系数
correlation_values = []
for i in range(data1.shape[1]):
    column = df1.columns[i+1]
    correlation, _ = pearsonr(data1[:, i], data2[:, i])
    correlation_values.append((column, correlation))

# 创建包含 Pearson 相关系数的数据框
correlation_df = pd.DataFrame(correlation_values, columns=['Column', 'Pearson Correlation'])

# 打印 RMSE 值
print(rmse_df)
rmse_df.to_csv(rmse_output, index=False)

# 打印 Pearson 相关系数
print(correlation_df)
correlation_df.to_csv(pearson_output, index=False)

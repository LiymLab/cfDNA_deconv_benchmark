# drop cpgs
# drop cpgs
import pandas as pd
import numpy as np
import random
import os

for m in [15,20,25,30,35,40,45,50,60,70,80,90,100]:
    for drop in [0.1,0.2,0.3,0.4,0.5]:
        for rep in range(20):
            
            ref_rep = f'/ref_drop_cpgs/drop_{drop}/rep_{rep}/'
            if not os.path.exists(ref_rep):
                os.makedirs(ref_rep)
                
            ref_name = f'/output_dir/selected_markers/filter_{m}_markers/Atlas.d{m}.l5.hg38.tsv'    
            df = pd.read_csv(ref_name, sep='\t')
            
            df_sample = df.sample(frac=drop, replace=False)
            df.drop(df_sample.index, inplace=True)


            df_sample.iloc[:, 8:43] = np.nan
            df_concatenated = pd.concat([df, df_sample])
            df_concatenated = df_concatenated.sort_values('startCpG')

            df_concatenated.to_csv(f'{ref_rep}/Atlas.U{m}.l5.hg38.tsv',sep='\t', index=False, na_rep='NA')
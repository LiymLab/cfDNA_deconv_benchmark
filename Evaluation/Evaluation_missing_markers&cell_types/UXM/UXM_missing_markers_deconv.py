#Before running this code, run the UXM_drop_markers.py script.

import subprocess 
medians = [15,20,25,30,35,40,45,50,60,70,80,90,100,150,200,250,300]
prop = [0.1,0.2,0.3,0.4,0.5]

for p in prop:
    for median in medians:
        for rep in range(20):
            cmd= f'uxm deconv /constrained_random_dis/*pat.gz -o output_dir/markers_missing/constrained_random_dis/filter_{median}_{p}_{rep}.csv --atlas /ref_drop_cpgs/drop_{p}/rep_{rep}/Atlas.U{median}.l5.hg38.tsv'
        
            subprocess.run(cmd,shell=True)


for p in prop:
    for median in medians:
        for rep in range(20):
            cmd= f'uxm deconv /uniform_dis/*pat.gz -o output_dir/markers_missing/uniform_dis/filter_{median}_{p}_{rep}.csv --atlas /ref_drop_cpgs/drop_{p}/rep_{rep}/Atlas.d{median}.l5.hg38.tsv'
        
            subprocess.run(cmd,shell=True)        



##bam2pat
bam_folder=/your/path/
mkdir -p /your/path/
find "$bam_folder" -name "*.bam" | xargs -n 10 -P 12 -I {} bash -c 'wgbstools bam2pat "{}" --genome hg38 --out_dir /output/pat/ -f'

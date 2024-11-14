#Taking thecfmethcyl dataset as an example
data_path=/rawdata/fastq
bam_path=/bam/path/
list="cfmethcyl_sample_names" 
bam_folder=/bam/path/
for sample in ${list} ; do 
    /TrimGalore-0.6.10/trim_galore -o ${data_path} --cores ${parallel} --clip_R1 15 --clip_R2 15 --three_prime_clip_R1 15 --clip_R2 2 --length 15 --phred33 --paired ${sample}_1.fastq.gz ${sample}_2.fastq.gz
    /Bismark-0.24.2/bismark --bowtie2 --genome hg38 -o ${data_path} --parallel ${parallel} -1 ${data_path}/${sample}_1_val_1.fq.gz -2 ${data_path}/${sample}_2_val_2.fq.gz 
    samtools view -@ ${parallel} -h -q 10 -f 2 -F 1796 ${data_path}/${sample}_1_val_1_bismark_bt2_pe.bam | samtools sort -n -@ ${parallel} -O bam -o ${data_path}/${sample}.nsorted.bam
    /Bismark-0.24.2/deduplicate_bismark --bam ${data_path}/${sample}.nsorted.bam --output_dir ${bam_path}
    #bam2pat   
    find "$bam_folder" -name "*.bam" | xargs -n 10 -P 12 -I {} bash -c 'wgbstools bam2pat "{}" --genome hg38 --out_dir ${bam_path} -f'
done

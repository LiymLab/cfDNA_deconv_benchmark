for i in subsample_.03 subsample_.16 subsample_.33 subsample_.50 subsample_.66 subsample_.83 
do
    wgbstools index ~/${i}/*.pat
    wgbstools pat2beta -o ~/${i}/ --genome hg38 ~/${i}/*.pat.gz
done

file_path="~/ref/"
log_file="~/processing.log"
process_file() {
    file=$1
    for i in 25 20 15 10 5 1
    do
        num=$(echo "scale=2; $i/30" | bc)
        filename=$(basename "$file" .pat.gz)
        outdir="~/subsample_${num}"
        mkdir -p "$outdir"
        wgbstools cview --sub_sample $num --genome hg38 "$file" > "${outdir}/${filename}.pat.gz"
        if [ $? -eq 0 ]; then
            echo "Successfully processed ${filename} with ratio $num" | tee -a "$log_file"
        else
            echo "Failed to process ${filename} with ratio $num" | tee -a "$log_file"
        fi
    done
}
export -f process_file
ls "${file_path}"/*.pat.gz | parallel -j 10 process_file

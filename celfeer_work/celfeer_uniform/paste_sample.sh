#!/bin/bash
for i in {1..100}
do
	paste ./regions_sample.txt ./sample_data/sample_${i}_data.txt > ./sample_data.txt
	mv -f ./sample_data.txt ./regions_sample.txt 
done
mv -f ./regions_sample.txt ./sample_data.txt
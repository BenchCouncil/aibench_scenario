#!/bin/bash
# get all filename in specified path

path=$pwd
files=$(ls $path)
for filename in $files
do
   echo $filename >> audios.txt
done

#!/bin/env sh

if [ $# != 1 ]; then
    echo "Please provide dictionary name"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Directory $1 does not exists"
    exit 1
fi

cur_dir=$(pwd)
output_name=$(basename "$1").jar
(cd "$1"; zip -r "${cur_dir}/${output_name}" ./*)

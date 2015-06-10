#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Syntax: $(basename $0) <output dir>"
    exit 1
fi

if [ ! -d $1 ]; then
    mkdir -p $1
fi

echo
echo You'll need X11 in one form or another
echo

docker run -v $1:/home/idv/work -p 8889:8889 -e DISPLAY=192.168.59.3:0  --rm -it ob-idv

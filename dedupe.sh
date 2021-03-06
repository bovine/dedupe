#!/bin/sh

BASEDIR="."
HASHFILE="/tmp/hashfile$$"

find $BASEDIR -type f -print0 | xargs -0 md5 > $HASHFILE

for HASH in `cut -d= -f2 $HASHFILE | sort | uniq -c | tr -s ' ' | egrep -v "^ 1 " | cut -d' ' -f3`; do
    echo "Duplicate hash $HASH found"
    grep $HASH $HASHFILE
done

rm -f $HASHFILE

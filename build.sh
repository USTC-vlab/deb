#!/bin/bash

set -e
set -o pipefail

mkdir -p build/
rm -f build/*

for d in */ ; do
    dname=${d/%\//}
    if [ "$dname" != "build" ]; then
        dpkg-deb --build "$dname"
        mv "$dname".deb build/
    fi
done

cd build/
dpkg-scanpackages . > Packages

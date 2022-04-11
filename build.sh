#!/bin/bash

set -eo pipefail

DIR=build
rm -f "$DIR"/*
mkdir -p "$DIR"

for d in */; do
  dname=${d/%\//}
  if [ "$dname" != "$DIR" ]; then
    dpkg-deb --build "$dname" "$DIR"/
  fi
done

cd "$DIR"
dpkg-scanpackages . > Packages

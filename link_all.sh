#!/bin/bash
for dir in $(ls -l | awk '$1 ~ /^d/ {print $NF}'); do
  stow "$dir"
done

#!/bin/bash
stow $(ls -la | awk '$1 ~ /^d.+/ && $NF !~ /\..*/ {print $NF}')

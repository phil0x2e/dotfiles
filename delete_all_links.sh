#!/bin/bash
stow -D $(ls -la | awk '$1 ~ /^d.+/ && $NF !~ /\..*/ {print $NF}')

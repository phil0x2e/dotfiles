#!/bin/bash
stow -D "$(ls -l | awk '$1 ~ /^d/ {print $NF}')"

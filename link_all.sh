#!/bin/bash
stow "$(ls -l | awk '$1 ~ /^d/ {print $NF}')"

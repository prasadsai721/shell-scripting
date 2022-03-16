#!/bin/bash

if [-e components/$1.sh]; then
echo "component dose not exit"
fi
bash components/$1.sh

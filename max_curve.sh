#!/bin/bash

rm -f col_max
#awk '{printf $1}' in.shear > col1
awk '{printf( "%0.6f\n", $1)}' shear.txt > col1
awk '{printf( "%0.6f\n", $2)}' shear.txt > col2
awk 'n < $0 {n=$0}END{print n}' col1 >> col_max
awk 'n < $0 {n=$0}END{print n}' col2 >> col_max
tail col_max
rm col1 col2

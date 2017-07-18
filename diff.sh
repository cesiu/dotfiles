#!/bin/bash

/bin/diff --unified=3 $1 $2 | sed 's/^-/\x1b[31m-/;s/^+/\x1b[32m+/;s/^@/\x1b[36m@/;s/$/\x1b[0m/'

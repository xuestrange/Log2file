# Log2file

[![Build Status](https://github.com/xuestrange/Log2file.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/xuestrange/Log2file.jl/actions/workflows/CI.yml?query=branch%3Amaster)
[![Coverage](https://codecov.io/gh/xuestrange/Log2file.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/xuestrange/Log2file.jl)


A Julia package used to log(write) some messages with the timestamp instantly to a log file.

## Usage
``` Julia
using Log2file
# set the length of seperator line
Log2file.set_line_length!(40)
# set the relative directory logfile
Log2file.set_logfile_path!("test", "test.txt")

# create the th log file if not existed, otherwise, empty it; add a line of program begins
@init_log
# add section seperator with the medium being the section title
@section "Step 1: Data Generation"
a = [1, 2, 3]
b = randn(2, 2)
# the main logging command
@log "a = $(a)"
@log "a = $(a), b = $(b)"
@section "END"
```
file in `path` will be written in the following lines:
``` Julia
2023-10-11 21:28:18 =============PROGRAM BEGINS=============
2023-10-11 21:28:18 ========Step 1: Data Generation=========
2023-10-11 21:28:18 a = [1, 2, 3] 
2023-10-11 21:28:18 a = [1, 2, 3], b = [-0.200330 -1.897242; 0.473479 0.508349] 
2023-10-11 21:28:18 ==================END===================
```

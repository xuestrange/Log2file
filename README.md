# Log2file
A Julia package used to log some messages to a log file.

## Key Points
```
using Log2file

Log2file.set_line_length!(40)
Log2file.set_logfile_path!("./test/test.txt")

@init_log
@section "Step 1: Data Generation"
a = [1, 2, 3]
b = randn(2, 2)
@log "a = $(a)"
@log "a = $(a), b = $(b)"
@section "END"
```
file in `path` will be written in the following lines:
```
2023-10-11 21:28:18 =============PROGRAM BEGINS=============
2023-10-11 21:28:18 ========Step 1: Data Generation=========
2023-10-11 21:28:18 a = [1, 2, 3] 
2023-10-11 21:28:18 a = [1, 2, 3], b = [-0.200330 -1.897242; 0.473479 0.508349] 
2023-10-11 21:28:18 ==================END===================
```

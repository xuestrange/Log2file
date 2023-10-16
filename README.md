# Log2file
[![CI](https://github.com/xuestrange/Log2file/actions/workflows/CI.yml/badge.svg?branch=main&event=status)](https://github.com/xuestrange/Log2file/actions/workflows/CI.yml)


A Julia package used to log(write) some messages with the timestamp instantly to a log file.

## Install
```Julia
# enter REPL, enter pkg mode
pkg> add https://github.com/xuestrange/Log2file.git
```
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
c = randn(4, 4)
# the main logging command
@log "a = $(a)" # one message
@logm "a = $(a)", "b = $(b)", c = "c" # multiple messages, Notes, use commas to seperate messsages instead of spaces.
@section "END"
```
## Output
``` Julia
# those are written in file
2023-10-16 12:02:34 =============PROGRAM BEGINS=============
2023-10-16 12:02:34 ========Step 1: Data Generation=========
2023-10-16 12:02:34 a = [1, 2, 3]
2023-10-16 12:02:34 a = [1, 2, 3]
                    b = [-0.173162 -0.476123; -0.698318 0.883876]
                    c = [0.597071 0.694631 1.023688 -0.778282; -0.086931 -0.177356 -0.371605 -0.291219; -0.353727 -1.477285 1.060820 -2.593262; -1.240470 -0.466444 -1.224540 0.792663]
2023-10-16 12:02:34 ==================END===================
```
``` Julia
# those are shown in REPl
[ Info: Precompiling Log2file [9348bb98-452d-4fd0-bebd-231ec7952d68]
[ Info: Line Length is set to: _LINE_LENGTH = "40"
[ Info: A global variable is created: _LOGFILE_PATH = "C:\Users\xue\Desktop\Log2file\test\test.txt"
2023-10-16 12:10:18 =============PROGRAM BEGINS=============
2023-10-16 12:10:18 ========Step 1: Data Generation=========
2023-10-16 12:10:18 a = [1, 2, 3]
2023-10-16 12:10:18 a = [1, 2, 3]
                    b = [-2.556943 -1.327557; 1.703257 2.820929]
                    c = [1.120194 -2.253843 -1.102650 0.282334; 0.198890 -0.215330 1.583031 0.485346; -0.070324 1.378542 1.146269 -0.736364; -0.135249 0.044350 0.485680 0.581215]
2023-10-16 12:10:18 ==================END===================
```



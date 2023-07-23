# Log2file
A Julia package used to log some messages to a log file.

## Key Points
```
set_log_file!(path)
@init_log
@line
@title "A title"
@log "A test"
```
file in `path` will be written in the following lines:
```
2023-07-23 17:06:50 Program begins
2023-07-23 17:06:50 =======================
2023-07-23 17:06:50 A title
2023-07-23 17:06:51 A test
```

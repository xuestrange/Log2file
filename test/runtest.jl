using Log2file

set_log_file!("./test/test.txt")

@init_log
@line
@title "A title"

a = 1
b = "a"

@log "1 ", "2 ", "b"
@log "1", "2"
@log  a, b
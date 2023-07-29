using Log2file

set_lline!(45)
set_log_file!("./test/test.txt")

@init_log
@section "Step 1: Data Generation"

a = 1
b = "a"

@log "1 ", "2 ", "b"
@log "1", "2"
@log  a, b
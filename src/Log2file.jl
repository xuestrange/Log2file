module Log2file
using Dates
log_file = ""
export set_log_file!, @init_log, @line, @title, @log, log_file
include("utils.jl")
end # module Log2file

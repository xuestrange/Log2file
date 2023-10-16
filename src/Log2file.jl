module Log2file
using Dates
using Printf
log_file = ""
export @init_log, @section, @log, @logm, _LOGFILE_PATH, _LINE_LENGTH
include("utils.jl")
end # module Log2file

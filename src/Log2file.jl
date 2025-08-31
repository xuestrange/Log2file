module Log2file
using Dates
log_file = ""
export @init_log, @section, @log, @logm, _LOGFILE_PATH, _LINE_LENGTH, _APPEND
include("utils.jl")
end # module Log2file

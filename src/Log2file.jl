module Log2file
using Dates
log_file = ""
export @init_log, @section, @log, _LOGFILE_PATH, _LINE_LENGTH
include("utils.jl")
end # module Log2file

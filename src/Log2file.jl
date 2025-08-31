module Log2file
using Dates
log_file = ""
export @init_log, @section, @log, @logm
include("utils.jl")
end # module Log2file

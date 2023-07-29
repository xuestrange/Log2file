module Log2file
using Dates
log_file = ""
export set_log_file!, set_lline!, @init_log, @section, @log, _log_file, _lline
include("utils.jl")
end # module Log2file

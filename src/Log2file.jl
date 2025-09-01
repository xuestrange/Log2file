module Log2file
using Dates
export Logger, DEFAULT_LOGGER 
export set_logfile_path!, set_line_length!, set_append_mode!
export @init_log, @section, @log, @logm
include("utils.jl")
end # module Log2file

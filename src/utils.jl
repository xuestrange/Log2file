"""
    Logger(; line_length=40, logfile_path="", append=true)

A mutable struct representing a logger configuration.

# Arguments
- `line_length::Int64`: Length of separator lines for sections (default: 40)
- `logfile_path::String`: Path to the log file (default: "")
- `append::Bool`: If true, append to existing file; if false, overwrite (default: true)

# Example
```julia
logger = Logger(line_length=50, logfile_path="mylog.txt", append=true)
```
"""
mutable struct Logger
	line_length::Int64
	logfile_path::String
	append::Bool

	function Logger(line_length = 40, logfile_path = "", append = true)
		logger = new(line_length, logfile_path, append)
		@info "Created logger with:"
		@info "Line length: $line_length"
		@info "Log file path: $logfile_path"
		@info "Write mode: $(append ? "append" : "overwrite")"
		return logger
	end
end

"""
    @init_log(title="PROGRAM BEGINS")

Initialize a log file with a header. Creates the file if it doesn't exist.

# Arguments
- `title`: Title string for the log header (default: "PROGRAM BEGINS")

# Example
```julia
@init_log "My Program Started"
```
"""
macro init_log(logger, title = "PROGRAM BEGINS")
	quote
		l = $(esc(logger))
		mode = l.append ? "a" : "w"
		formatted = rpad(lpad($title, floor(Int64, l.line_length/2 + length($title)/2), "="), l.line_length, "=")
		println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", formatted)
		open(l.logfile_path, mode) do io
			write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", formatted, "\n")
		end
	end
end

"""
    set_logfile_path!(logger::Logger, path)

Set the log file path for a logger. The path is joined with the current working directory.

# Arguments
- `logger::Logger`: The logger instance
- `path`: Path to the log file (relative to current directory)

# Example
```julia
set_logfile_path!(DEFAULT_LOGGER, "logs/mylog.txt")
```
"""
function set_logfile_path!(logger::Logger, path)
	logger.logfile_path = joinpath(pwd(), path)
end

"""
    set_line_length!(logger::Logger, l::Int64)

Set the line length used for formatting section separators.

# Arguments
- `logger::Logger`: The logger instance
- `l::Int64`: New line length

# Example
```julia
set_line_length!(DEFAULT_LOGGER, 60)
```
"""
function set_line_length!(logger::Logger, l::Int64)
	logger.line_length = l
end

"""
    set_append_mode!(logger::Logger, l::Bool)

Set whether to append to existing log file or overwrite it.

# Arguments
- `logger::Logger`: The logger instance
- `l::Bool`: true for append mode, false for overwrite mode

# Example
```julia
set_append_mode!(DEFAULT_LOGGER, true)  # Set to append mode
```
"""
function set_append_mode!(logger::Logger, l::Bool)
	logger.append = l
end

"""
    @section(title)

Add a section header to the log file with centered title and separator lines.

# Arguments
- `title`: Title string for the section

# Example
```julia
@section "Data Processing Phase"
```
"""
macro section(logger, title)
	quote
		l = $(esc(logger))
		local formatted = rpad(lpad($title, floor(Int64, l.line_length/2 + length($title)/2), "="), l.line_length, "=")
		println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", formatted)
		open(l.logfile_path, "a") do io
			write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", formatted, "\n")
		end
	end
end

"""
    @log(message)

Write a single message to the log file with timestamp.

# Arguments
- `message`: The message to log

# Example
```julia
x = [1, 2, 3]
@log "Processing array: \$x"
```
"""
macro log(logger, messages)
	quote
		try
			open($(esc(logger)).logfile_path, "a") do io
				println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $(esc(messages)))
				write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $(esc(messages)), "\n")
			end
		catch e
			@error "Failed to write to log file: $e"
		end
	end
end

"""
    @logm(messages...)

Write multiple messages to the log file. First message includes timestamp,
subsequent messages are indented.

# Arguments
- `messages...`: Variable number of messages to log

# Example
```julia
@logm "Starting process", "Step 1 complete", "Step 2 complete"
```
"""
macro logm(logger, messages...)
	quote
		try
			open($(esc(logger)).logfile_path, "a") do io
				iter = 1
				for m in $(esc.(messages)...)
					if iter == 1
						println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", m)
						write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", m, "\n")
					else
						println(" "^20, m)
						write(io, " "^20, m, "\n")
					end
					iter += 1
				end
			end
		catch e
			@error "Failed to write to log file: $e"
		end
	end
end
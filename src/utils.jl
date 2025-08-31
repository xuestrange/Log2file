_LINE_LENGTH = 40
_LOGFILE_PATH = joinpath(pwd(), "test.txt")
_APPEND = true
"""
Initialize you log file. Usually used at the beginning of you programs, the macro will create a file with one line indicating the beginning of the program.
## Arguments
`append`: bool, if true, then overwrite the file, append otherwise.
"""
macro init_log(title = "PROGRAM BEGINS")
	global _LOGFILE_PATH
	global _APPEND
	mode = _APPEND ? "a" : "w"
	quote
		println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="))
		open($_LOGFILE_PATH, $mode) do io
			write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="), "\n")
		end
	end
end
"""
Create a global variable named `_LOGFILE_PATH= path`
# Arguments
+ `path`: string
# Examples
If you set `Log2file.set_logfile_path!("test", "records.txt")`, then the log file directory will be "pwd()/test/records.txt"
# Warn
Don't use it like this "Log2file.set_logfile_path!("./test/records.txt")", because Unix-like and Windows systems differ in the format of path.
"""
function set_logfile_path!(path...)
	global _LOGFILE_PATH = joinpath(pwd(), path...)
	@info "A global variable is created: _LOGFILE_PATH = \"$_LOGFILE_PATH\""
end
function set_line_length!(l::Int64)
	global _LINE_LENGTH = l
	@info "Line Length is set to: _LINE_LENGTH = \"$_LINE_LENGTH\""
end
"
Initialize the write mode for the log file, if `l` is true, `append mode`, else, "overwrite mode"
"
function set_append_mode!(l::Bool)
	global _APPEND = l == true ? true : false
	msg = _APPEND == true ? "append" : "overwrite"
	@info "Write mode is set to: \"$msg\""
end

"""
Create a title line into your log file
# Arguments
- `title`: string
"""
macro section(title)
	global _LOGFILE_PATH
	quote
		println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="))
		open($_LOGFILE_PATH, "a") do io
			write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="), "\n")
		end
	end
end

"""
Add messages to your log file
# Arguments
- `message`: a string
"""
macro log(messages)
	global _LOGFILE_PATH
	quote
		open($_LOGFILE_PATH, "a") do io
			println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $(esc(messages)))
			write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $(esc(messages)), "\n")
		end
	end
end

"""
Add messages to your log file
# Arguments
- `messages`: many strings
"""
macro logm(messages...)
	global _LOGFILE_PATH
	quote
		open($_LOGFILE_PATH, "a") do io
			# println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $(esc(messages)), "\n")
            iter = 1
			for m in $(esc.(messages)...)
                if iter == 1

                    println(Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ",  m)
                    write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ",  m, "\n")
                else
                    println(" "^20,  m)
                    write(io, " "^20,  m, "\n")
                end
                iter += 1
			end
		end
	end
end

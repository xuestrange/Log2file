_LINE_LENGTH = 40
_LOGFILE_PATH = joinpath(pwd(), "test.txt")
"""
Initialize you log file. Usually used at the beginning of you programs, the macro will create a file with one line indicating the beginning of the program.
"""
macro init_log(title = "PROGRAM BEGINS")
    global _LOGFILE_PATH
    quote
        open($_LOGFILE_PATH, "w") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ",rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="), "\n")
        end
    end
end
"""
Create a global variable named `_LOGFILE_PATH= path`
# Arguments
+ `path`: string
"""
function set_logfile_path!(path...)
    global _LOGFILE_PATH= joinpath(pwd(), path...)
    @info "A global variable is created: _LOGFILE_PATH = \"$_LOGFILE_PATH\""
end
function set_line_length!(l::Int64)
    global _LINE_LENGTH = l
    @info "Line Length is set to: _LINE_LENGTH = \"$_LINE_LENGTH\""
end

"""
Create a title line into your log file
# Arguments
- `title`: string
"""
macro section(title)
    global _LOGFILE_PATH
    quote
        open($_LOGFILE_PATH, "a") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", rpad(lpad($title, floor(Int64, _LINE_LENGTH / 2 + length($title) / 2), "="), _LINE_LENGTH, "="), "\n")
        end
    end
end


"""
Add messages to your log file
# Arguments
- `messages`: many strings
"""
macro log(messages...)
    global _LOGFILE_PATH
    quote
        open($_LOGFILE_PATH, "a") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ",  reduce(*, string.($(esc(messages...))) .* " "), "\n")
        end
    end
end
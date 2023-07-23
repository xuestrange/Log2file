"""
Create a global variable named `log_file = path`
# Arguments
+ `path`: string
"""
function set_log_file!(path)
    global log_file = path
    @info "A global variable is created: log_file = \"$log_file\""
end

"""
Create a line "============================" used to seperated blocks
"""
macro line()
    quote
        global log_file
        open($log_file, "a") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " =======================\n")
        end
    end
end

"""
Create a title line into your log file
# Arguments
- `title`: string
"""
macro title(title)
    global log_file
    quote
        open($log_file, "a") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ", $title, "\n")
        end
    end
end

"""
Initialize you log file. Usually used at the beginning of you programs, the macro will create a file with one line indicating the beginning of the program.
"""
macro init_log()
    global log_file
    quote
        open($log_file, "w") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " Program begins", "\n")
        end
    end
end
"""
Add messages to your log file
# Arguments
- `messages`: many strings
"""
macro log(messages...)
    global log_file
    quote
        open($log_file, "a") do io
            write(io, Dates.format(now(), "yyyy-mm-dd HH:MM:SS"), " ",  reduce(*, string.($(esc(messages...)))), "\n")
        end
    end
end
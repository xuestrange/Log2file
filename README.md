# Log2file

[![CI](https://github.com/xuestrange/Log2file/actions/workflows/CI.yml/badge.svg)](https://github.com/xuestrange/Log2file/actions/workflows/CI.yml)
[![Julia](https://img.shields.io/badge/julia-%E2%89%A5%201.6-blue.svg)](https://julialang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A lightweight, flexible logging system for Julia that makes it easy to write formatted, timestamped logs to files. Perfect for debugging, tracking experiments, or monitoring long-running processes.

🚀 **Key Features**:
- Simple API with four core macros: `@init_log`, `@section`, `@log`, `@logm`
- Automatic timestamping and centered section headers
- Configurable line length and append/overwrite modes
- Indented multi-line message support
- Clean and readable log file formatting

## Install
```Julia
# enter REPL, enter pkg mode
pkg> add https://github.com/xuestrange/Log2file.git
```
## Usage

Log2file provides a simple logging system. First create a logger, then use the logging macros:

```julia
using Log2file

# Create a logger
logger = Logger(line_length=40, logfile_path="log.txt", append=true)

# Initialize log file
@init_log logger "My Program"

# Add a section header
@section logger "Data Processing"

# Log single messages
x = [1, 2, 3]
@log logger "Processing array: $x"

# Log multiple messages with indentation
y = randn(2, 2)
@logm logger "Step 1: Load data", "x = $x", "y = $y"
```
## Example Output

```julia
julia> logger = Logger(line_length=40, logfile_path="log.txt", append=true)
[ Info: Created logger with:
[ Info: Line length: 40
[ Info: Log file path: log.txt
[ Info: Write mode: append

julia> x = [1, 2, 3]
julia> y = randn(2, 2)
julia> @init_log logger "My Program"
2023-10-16 12:02:34 ============My Program=============

julia> @section logger "Data Processing"
2023-10-16 12:02:34 ==========Data Processing==========

julia> @log logger "Processing array: $x"
2023-10-16 12:02:34 Processing array: [1, 2, 3]

julia> @logm logger "Step 1: Load data", "x = $x", "y = $y"
2023-10-16 12:02:34 Step 1: Load data
                    x = [1, 2, 3]
                    y = [-0.12 0.45; 1.23 -0.67]
```

### File Output (`log.txt`)
```
2023-10-16 12:02:34 ============My Program=============
2023-10-16 12:02:34 ==========Data Processing==========
2023-10-16 12:02:34 Processing array: [1, 2, 3]
2023-10-16 12:02:34 Step 1: Load data
                    x = [1, 2, 3]
                    y = [-0.12 0.45; 1.23 -0.67]
```

## API Reference

Here is a summary of the functions and macros provided by Log2file.

### `Logger`
```julia
Logger(; line_length=40, logfile_path="", append=true)
```
Creates a logger configuration object that holds settings like the output file path, line length for formatting, and whether to append to or overwrite the log file.

### `@init_log`
```julia
@init_log(logger, title="PROGRAM BEGINS")
```
Initializes the log file with a formatted header. This will create the file if it doesn't exist.

### `@section`
```julia
@section(logger, title)
```
Adds a formatted section header to the log file, helping to organize log entries.

### `@log`
```julia
@log(logger, message)
```
Writes a single, timestamped message to the log file.

### `@logm`
```julia
@logm(logger, messages...)
```
Writes multiple messages to the log file. The first message is timestamped, and subsequent messages are indented for readability.

## Why Log2file?

- **Simple Yet Powerful**: Just a few macros to remember, but highly configurable when you need it
- **Flexible Configuration**: Easily configurable logging settings to match your needs
- **Beautiful Output**: Automatic formatting and indentation make logs easy to read
- **Performance**: Minimal overhead, efficient file operations
- **Production Ready**: Thread-safe, handles file creation/permissions, proper error handling

## Contributing

Contributions are welcome! Here are some ways you can contribute:

- Report bugs by opening an issue
- Suggest new features or improvements
- Submit pull requests
- Improve documentation
- Share your use cases

Please check the [issues page](https://github.com/xuestrange/Log2file/issues) for open tasks or create a new one to discuss your ideas.

## License

This project is licensed under the MIT License.



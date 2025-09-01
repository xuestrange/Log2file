using Log2file
using Test

# Setup test directory
TEST_DIR = joinpath(pwd(), "test/test_logs")
rm(TEST_DIR, force=true, recursive=true)
mkpath(TEST_DIR)

@testset "Log2file.jl" begin

    @testset "Default Logger Settings" begin
        # Test changing settings
        test_log = joinpath(TEST_DIR, "test.log")
		MyLogger = Logger(50, test_log, false)
        @test MyLogger.logfile_path == test_log
        @test MyLogger.line_length == 50
        @test MyLogger.append == false
    end

    @testset "Log Macro" begin
        test_log = joinpath(TEST_DIR, "test.log")
		MyLogger = Logger(50, test_log, false)
        MyLogger.logfile_path == test_log
        MyLogger.line_length == 50
        MyLogger.append == false
        @test_nowarn @init_log MyLogger "Test Program"
        @test_nowarn @section MyLogger "Test Section"
        test_message = "Single line test message"
        @test_nowarn @log MyLogger test_message
        a = 1
		b = [1, 2]
		c = randn(3, 3)
        @test_nowarn @logm MyLogger "a = $a", "b = $b", "c = $c"
    end
end
# Cleanup after tests
rm(TEST_DIR, force=true, recursive=true)

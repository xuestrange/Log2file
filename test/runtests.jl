using Log2file
using Test

@testset "Log2file.jl" begin
	# Write your tests here.
    @test try 
        Log2file.set_line_length!(40)
        Log2file.set_logfile_path!("./test/test.txt")

        @init_log
        @section "Step 1: Data Generation"
        a = [1, 2, 3]
        b = randn(2, 2)
        @log "a = $(a)"
        @log "a = $(a), b = $(b)"
        @section "END"
       true 
    catch
        false
    end
end

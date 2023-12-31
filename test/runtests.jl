using Log2file
using Test
Log2file.set_line_length!(40)
Log2file.set_logfile_path!("test", "test.txt")
function test_log2file()
	@init_log
	@section "Step 1: Data Generation"
	a = [1, 2, 3]
	b = randn(2, 2)
	c = randn(4, 4)
	@log "a = $(a)"
	@logm "a = $(a)", "b = $(b)", "c = $(c)"
	@section "END"
	return true
end
@testset "Log2file.jl" begin
	# Write your tests here.
	@test test_log2file()
end

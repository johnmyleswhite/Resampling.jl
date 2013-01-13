#
# Correctness Tests
#

require("Resampling")
using Resampling

my_tests = ["test/splitrandom.jl",
            "test/resample.jl",
            "test/jackknife.jl",
            "test/bootstrap.jl",
            "test/crossvalidate.jl"]

println("Running tests:")

for my_test in my_tests
    println(" * $(my_test)")
    include(my_test)
end

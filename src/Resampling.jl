using DataFrames

module Resampling
	using DataFrames

	export bootstrap,
	       crossvalidate,
	       jackknife,
	       kfold_crossvalidate,
	       resample,
	       splitrandom

	include("splitrandom.jl")
	include("resample.jl")
	include("jackknife.jl")
	include("bootstrap.jl")
	include("crossvalidate.jl")
end

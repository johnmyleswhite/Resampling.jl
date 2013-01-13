using DataFrames

module Resampling
	using DataFrames

	export bootstrap,
	       crossvalidate,
	       jackknife,
	       kfold_crossvalidate,
	       resample,
	       splitrandom

	include(joinpath(julia_pkgdir(), "Resampling", "src", "splitrandom.jl"))
	include(joinpath(julia_pkgdir(), "Resampling", "src", "resample.jl"))
	include(joinpath(julia_pkgdir(), "Resampling", "src", "jackknife.jl"))
	include(joinpath(julia_pkgdir(), "Resampling", "src", "bootstrap.jl"))
	include(joinpath(julia_pkgdir(), "Resampling", "src", "crossvalidate.jl"))
end

function bootstrap(df::AbstractDataFrame,
	               statistic::Function,
	               runs::Integer,
	               proportion::Real)
	# TODO: Make this the return type of statistic()
	res = Array(Float64, runs)

	for i in 1:runs
		resampled_df = resample(df, iround(nrow(df) * proportion))
		res[i] = statistic(resampled_df)
	end

	return res
end

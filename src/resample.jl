function resample(df::AbstractDataFrame, s::Integer)
	n = nrow(df)

	included = Array(Int, s)
	for i in 1:s
		included[i] = rand(1:n)
	end

	return df[included, :]
end

function jackknife(df::AbstractDataFrame, statistic::Function)
	n = nrow(df)

	results = Array(Float64, n)

	for i in 1:n
		indices = Array(Int, n - 1)
		idx = 0
		for j in 1:n
			if j != i
				idx += 1
				indices[idx] = j
			end
		end
		results[i] = statistic(df[indices, :])
	end

	return results
end

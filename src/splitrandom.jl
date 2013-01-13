function splitrandom_indices(n::Integer, proportion::Real)
	indices = [1:n]
	shuffle!(indices)
	splitindex = iround(n * proportion)
	return indices[1:splitindex], indices[(splitindex + 1):n]
end

function splitrandom(df::AbstractDataFrame, proportion::Real)
	included, excluded = splitrandom_indices(nrow(df), proportion)
	return df[included, :], df[excluded, :]
end

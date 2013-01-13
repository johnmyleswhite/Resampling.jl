function crossvalidate(df::AbstractDataFrame,
	                   train::Function,
	                   test::Function,
	                   n::Integer,
	                   proportion::Real)
	# TODO: Make these the return types of train and test
	training_results = Array(Any, n)
	test_results = Array(Any, n)

	for i in 1:n
		train_df, test_df = splitrandom(df, proportion)
		training_results[i] = train(train_df)
		test_results[i] = test(test_df, training_results[i])
	end

	return training_results, test_results
end

function kfold_crossvalidate(df::AbstractDataFrame,
	                         train::Function,
	                         test::Function,
	                         k::Integer)
	n_total = nrow(df)
	n_fold = iround(n_total / k)

	indices = [1:n_total]
	shuffle!(indices)

	# TODO: Make these the return types of train and test
	training_results = Array(Any, k)
	test_results = Array(Any, k)

	for fold in 1:k
		lower_bound = 1 + (fold - 1) * n_fold
		upper_bound = fold * n_fold

		included = Array(Int, n_total - n_fold)
		excluded = Array(Int, n_fold)

		i_included, i_excluded = 0, 0
		for index in 1:n_total
			if lower_bound <= index <= upper_bound
				i_excluded += 1
				excluded[i_excluded] = index
			else
				i_included += 1
				included[i_included] = index
			end
		end
		included = included[1:i_included]
		excluded = excluded[1:i_excluded]

		training_set = df[indices[included], :]
		test_set = df[indices[excluded], :]

		training_results[fold] = train(training_set)
		test_results[fold] = test(test_set, training_results[fold])
	end

	return training_results, test_results
end

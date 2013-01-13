df = DataFrame()
df["A"] = 1:100

function train(df)
	mean(df["A"])
end

function test(df, m)
	sqrt(mean((df["A"] - m).^2))
end

n_reps = 100
training_results, test_results = crossvalidate(df, train, test, n_reps, 0.75)
@assert length(training_results) == n_reps
@assert length(test_results) == n_reps
@assert all(test_results .> 0.0)
@assert norm(std(df["A"]) - mean(float(test_results))) < 1

k = 10
training_results, test_results = kfold_crossvalidate(df, train, test, k)
@assert length(training_results) == k
@assert length(test_results) == k
@assert all(test_results .> 0.0)
@assert norm(std(df["A"]) - mean(float(test_results))) < 1

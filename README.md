Resampling.jl
=============

Tools for resampling data to assess model fits

# API

Depending on the level of granularity, you can use several functions for
resampling data:

* `splitrandom(df::DataFrame, proportion::Real)`: Use this to split `df` into two randomly chosen pieces. If `proportion == 0.75`, the first piece will contain ~75% of the data and the second piece will ~25% of the data.
* `resample(df::DataFrame, n::Integer)`: Use this to generate a new data set of size `n` that is resampled with replacement from the rows of `df`.
* `jackknife(df::DataFrame, statistic::Function)`: Use this to run the jackknife. The Jackknife moves through the data, removing one row at a time and then applying the function `statistic` to the remaining data. The results of all calls to `statistic` are stored in a vector that is returned to the caller.
* `bootstrap(df::DataFrame, statistic::Function, n::Integer, proportion::Real)`: Use this to run the nonparametric bootstrap. The bootstrap resamples the data `n` times with each resampled data set containing `proportion` of the data. The function `statistic` is called on each resampled data set. The results of all calls to `statistic` are stored in a vector that is returned to the caller.
* `crossvalidate(df::DataFrame, train::Function, test::Function, n::Integer, proportion::Real)`: Use this function to fit a model using the `train` function on `n` resampled data sets and then test the fitted model using the `test` function on those same data sets. Each time, the training data set will contain `proportion` of `df` and `1 - proportion` will be held out as a test data set.
* `kfold_crossvalidate(df::DataFrame, train::Function, test::Function, k::Integer)`: Use this function to fit a model using the `train` function on `k` data sets and then test the fitted model using the `test` function on those same data sets. Each time, the training data set will contain the majority of the data with one of `k` folds removed.

# Usage Examples

Using `splitrandom`:

    using DataFrames

    df = DataFrame()
    df["A"] = 1:100

    df1, df2 = splitrandom(df, 0.75)

Using `resample`:

    using DataFrames

    df = DataFrame()
    df["A"] = 1:100

    new_df = resample(df, 100)

Using `jackknife`:

    using DataFrames

    df = DataFrame()
    df["A"] = 1:100

    resampled_means = jackknife(df, df -> mean(df["A"]))
    se_hat = std(resampled_means)

Using `bootstrap`:

    using DataFrames

    df = DataFrame()
    df["A"] = 1:100

    resampled_means = bootstrap(df, df -> mean(df["A"]), 1_000, 0.90)
    se_hat = std(resampled_means)

Using `crossvalidate`:

    using DataFrames

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

Using `kfold_crossvalidate`:

    using DataFrames

    df = DataFrame()
    df["A"] = 1:100

    function train(df)
        mean(df["A"])
    end

    function test(df, m)
        sqrt(mean((df["A"] - m).^2))
    end

    k = 10
    training_results, test_results = kfold_crossvalidate(df, train, test, k)

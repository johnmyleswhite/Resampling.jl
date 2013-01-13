df = DataFrame()
df["A"] = 1:100

means = bootstrap(df, df -> mean(df["A"]), 1_000, 0.90)
@assert isequal(length(means), 1_000)
@assert isequal(eltype(means), Float64)

se_hat = std(bootstrap(df, df -> mean(df["A"]), 1_000, 0.90))
@assert isa(se_hat, Float64)
@assert 0.0 <= se_hat <= 10.0

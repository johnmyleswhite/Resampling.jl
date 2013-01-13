df = DataFrame()
df["A"] = 1:100

means = jackknife(df, df -> mean(df["A"]))
@assert length(means) == nrow(df)

se_hat = std(jackknife(df, df -> mean(df["A"])))
@assert 0.0 <= se_hat <= 10.0

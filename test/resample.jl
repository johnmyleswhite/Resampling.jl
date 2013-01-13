df = DataFrame()
df["A"] = 1:100

@assert nrow(resample(df, 0)) == 0
@assert nrow(resample(df, 90)) == 90
@assert nrow(resample(df, 120)) == 120

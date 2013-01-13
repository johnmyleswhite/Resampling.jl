df = DataFrame()
df["A"] = 1:100

df1, df2 = splitrandom(df, 0.75)
@assert isequal(nrow(df1), 75)
@assert isequal(nrow(df2), 25)

##Langkah 1 mengumpulkan data
#9.835 transaksi dengan 169 jenis barang

#Ubah directory and simpan file di dalam folder Mydata
setwd("f:\\Mydata")

#Langkah 2 Eksplor dan prepare data

#load the grocery data ke sparse matrix

install.packages("arules")
library(arules)
groceries <- read.transactions("groceries.csv", sep = ",")
summary(groceries)

#Melihat itemset untuk 5 transaksi
inspect(groceries[1:5])

# Mengetahui frekuensi dari item
itemFrequency(groceries[, 1:3])

# Visualisasi frekuensi per items
itemFrequencyPlot(groceries, support = 0.1)

itemFrequencyPlot(groceries, topN = 20)

# Visualisasi sparse matrix untuk 5 transaksi pertama
image(groceries[1:5])

# Visualisasi random sample dari 100 transaksi
image(sample(groceries, 100))

## Langkah 3 Menguji model dari data
# Menghasilkan rule dengan apriori
apriori(groceries)

# setting support dan confidence levels
groceryrules <- apriori(groceries, parameter = list(support =
                                                      0.006, confidence = 0.25, minlen = 2))
groceryrules

## Langkah 4 mengevaluasi performance model 
summary(groceryrules)

# Melihat 3 itemset pertama dari rule 
inspect(groceryrules[1:3])

## Langkah 5 meningkatkan performance model

# mengsortir groceryrules dg "lift"
inspect(sort(groceryrules, by = "lift")[1:5])

# Filtering items "berries"
berryrules <- subset(groceryrules, items %in% "berries")
inspect(berryrules)

# Buat groceryrules CSV file
write(groceryrules, file = "groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# Ubah menjadi data frame
groceryrules_df <- as(groceryrules, "data.frame")
str(groceryrules_df)

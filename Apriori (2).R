#Apriori dengan data sederhana

##Langkah 1 mengumpulkan data
#6 transaksi dengan 10 jenis barang

#Ubah directory and simpan file di dalam folder Mydata
setwd("f:\\Mydata")

##Langkah 2 Eksplor dan prepare data

#load the grocery data ke sparse matrix

install.packages("arules")
library(arules)
Belanja <- read.transactions("Struk Belanja.csv", sep = ",")
summary(Belanja)

#Melihat itemset dari transaksi
inspect(Belanja)
# Mengetahui proporsi transaksi dari item
itemFrequency(Belanja)

# Visualisasi frekuensi per items
itemFrequencyPlot(Belanja, support = 0.1)

itemFrequencyPlot(Belanja, topN = 10)

# Visualisasi sparse matrix untuk transaksi
image(Belanja)

# Visualisasi random sample dari 6 transaksi
image(sample(Belanja, 6))

## Langkah 3 Menguji model dari data
# Menghasilkan rule dengan apriori
apriori(Belanja)

## Langkah 4 mengevaluasi performance model 
summary(Belanjarules)
inspect(subset(Belanjarules, support > 0.1666667 & lift > 1))
Belanjarules
## Langkah 5 meningkatkan performance model

# Buat Belanjarules CSV file
write(Belanjarules, file = "Belanjarules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# Ubah menjadi data frame
Belanjarules_df <- as(Belanjarules, "data.frame")
str(Belanjarules_df)

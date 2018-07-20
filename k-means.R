##Langkah 1 mengumpulkan data
#Terdiri dari 30000 pengamatan
#dengan 4 variabel karakteristik pribadi dan 36 variabel minat
setwd("f:\\Mydata")
teens <- read.csv("snsdata.csv")
## Langkah 2 Mengeksplor dan menyiapkan data
#Cek struktur data
str(teens)
#Mencari missing value non numeric data
table(teens$gender)
#Missing value variabe gender
table(teens$gender, useNA = "ifany")
#Mencari missing value non numeric data
summary(teens$age)
#Usia remaja antara 13 sampai dg 20
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)
#Terlihat lebih aktual usia remaja
summary(teens$age)
#Variabel dummy untuk missing value 
teens$female <- ifelse(teens$gender == "F" &
                         +                            !is.na(teens$gender), 1, 0)
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)
table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")
#Rata-rata usia remaja dengan missing value
mean(teens$age)
#Rata-rata usia remaja untuk menghilangkan missing value
mean(teens$age, na.rm = TRUE)
#Cek rata2 usia remaja tiap tahun
aggregate(data = teens, age ~ gradyear, mean, na.rm = TRUE)
#mengembalikan data.frame dari fungsi aggregate() ke bentuk semula
ave_age <- ave(teens$age, teens$gradyear, FUN =
                 +                    function(x) mean(x, na.rm = TRUE))
teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)
summary(teens$age)
##Langkah 3 Menguji model data
library(stats)
#Jumlah 6 variabel yang dianalisa adalah 36
interest <- teens[5:40]
#z_score statdarisasi
interests_z <- as.data.frame(lapply(interests, scale))
#untuk menjamin hasil konsisten (non random)
set.seed(2345)
#k-means dengan 5 cluster
teens_clusters <- kmeans(interests_z, 5)
##Langkah 4 Evaluasi kinerja model
#untuk mendapatkan ukuran cluster
teens_clusters$size
#Uji centroids cluster
teens_clusters$centers
##Langkah 5 Meningkatkan performa model
#mengaplikasikan cluster ke data.frame
teens$cluster <- teen_clusters$cluster
#Melihat 5 record pertama
teens[1:5, c("cluster", "gender", "age", "friends")]
#rata-rata usia dg pengklusteran
aggregate(data = teens, age ~ cluster, mean)
#proporsi wanita dg pengklusteran
aggregate(data = teens, female ~ cluster, mean)
#rata-rata jumlah teman dg pengklusteran
aggregate(data = teens, friends ~ cluster, mean)




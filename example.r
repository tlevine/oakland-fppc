library(ggplot2)

if (!('fppc' %in% ls())) {
  fppc <- read.csv('fppc.csv')
}
fppc.slice <- fppc[c(
  'Filer_NamL',
  'Committee_Type',
  'Rpt_Date',
  'From_Date',
  'Thru_Date',
  'Rec_Type',
  'Tran_NamL',
  'Tran_NamF',
  'Tran_City',
  'Tran_State',
  'Tran_Zip4',
  'Tran_Emp',
  'Tran_Amt1',
  'Tran_Amt2'
)]
fppc.slice$Zip <- substr(fppc.slice$Tran_Zip4, 1, 5)

oakland <- subset(fppc.slice, Tran_City == 'Oakland')
oakland$Zip <- factor(oakland$Zip, levels = names(sort(table(oakland$Zip), decreasing = TRUE)))

p <- ggplot(oakland) +
  aes(x = Zip) + geom_bar() + coord_flip()

m <- lm(Tran_Amt2 ~ Zip, data = oakland)

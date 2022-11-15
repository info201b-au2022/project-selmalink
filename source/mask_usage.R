library("dplyr")

covid <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
national_mask_use <- covid %>%
  select(c("NEVER", "RARELY", "SOMETIMES", "FREQUENTLY", "ALWAYS")) %>%
  colMeans()

make_pie_chart <- function() {
  lbls <- c("NEVER", "RARELY", "SOMETIMES", "FREQUENTLY", "ALWAYS")
  pct <- round(national_mask_use/sum(national_mask_use)*100)
  lbls <- paste(lbls, pct)
  lbls <- paste0(lbls, "%")
  pie(national_mask_use, labels = lbls, col = rainbow(length(lbls)),
      main="National Mask Usage During COVID Pandemic")
}



library("dplyr")

# COVID death count dataset
covid_death_counts <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Provisional_COVID-19_Death_Counts_in_the_United_States_by_County.csv")

# Vaccine hesitancy dataset
vaccine_hesitancy <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Vaccine_Hesitancy_for_COVID-19__County_and_local_estimates.csv")

# Election result by county dataset
election_results <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/countypres_2000-2020.csv")

# Mask use by county dataset
mask_use_data <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")

# Summary of data code

# Average covid death counts
avg_covid_deaths <- covid_death_counts %>%
  summarize(avg_deaths = round(mean(Deaths.involving.COVID.19, na.rm = TRUE), 0))
avg_covid_deaths

# Average of never using a mask
never_mask_avg <- mask_use_data %>%
  summarize(Never = round(mean(NEVER, na.rm = TRUE), 2))
never_mask_avg

# Average of sometimes using a mask
sometimes_mask_avg <- mask_use_data %>%
  summarize(Sometimes = round(mean(SOMETIMES, na.rm = TRUE), 2))
sometimes_mask_avg

# Average of always using a mask
always_mask_avg <- mask_use_data %>%
  summarize(Always = round(mean(ALWAYS, na.rm = TRUE), 2))
always_mask_avg

# Average of percentage of adults vaccinated
percent_adults_vaccinated <- vaccine_hesitancy %>%
  summarize(percent_vaccinated = round(mean(Percent.adults.fully.vaccinated.against.COVID.19..as.of.6.10.21., na.rm = TRUE), 2))
percent_adults_vaccinated

# 2020 election total votes per candidate
num_votes_trump <- election_results %>%
  filter(year == 2020, candidate == "DONALD J TRUMP") %>%
  summarize(total_votes = sum(candidatevotes))
num_votes_trump
  
num_votes_biden <- election_results %>%
  filter(year == 2020, candidate == "JOSEPH R BIDEN JR") %>%
  summarize(total_votes = sum(candidatevotes))
num_votes_biden

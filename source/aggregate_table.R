library("dplyr")
mask_use_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
mask_use_df <- mask_use_df %>%
  mutate(some_times_to_always = SOMETIMES + FREQUENTLY + ALWAYS, never_to_rarely = NEVER + RARELY)

death_count_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Provisional_COVID-19_Death_Counts_in_the_United_States_by_County.csv")
death_count_df <- death_count_df %>%
  select(c("State", "FIPS.County.Code", "Deaths.involving.COVID.19",))

vaccine_hesit_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Vaccine_Hesitancy_for_COVID-19__County_and_local_estimates.csv")
vaccine_hesit_df <- vaccine_hesit_df %>%
  select(c("FIPS.Code", "Estimated.hesitant", "Estimated.hesitant.or.unsure", "Estimated.strongly.hesitant")) %>%
  mutate(total_unsure_to_hesitant = Estimated.hesitant + Estimated.hesitant.or.unsure + Estimated.strongly.hesitant)

election_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/countypres_2000-2020.csv")
election_df <- election_df %>%
  select(c("year", "county_fips", "candidate", "party", "candidatevotes", "totalvotes", "mode")) %>%
  filter(year == 2020, candidate == "JOSEPH R BIDEN JR" | candidate =="DONALD J TRUMP")

joe_biden_df <- election_df %>%
  filter(candidate == "JOSEPH R BIDEN JR") %>%
  group_by(county_fips, totalvotes) %>%
  summarize(biden_total_votes = sum(candidatevotes, na.rm = TRUE)) %>%
  ungroup()

donald_trump_df <- election_df %>%
  filter(candidate == "DONALD J TRUMP") %>%
  group_by(county_fips) %>%
  summarize(trump_total_votes = sum(candidatevotes, na.rm = TRUE)) %>%
  ungroup()

#merging all data frames
final_df <- joe_biden_df %>%
  left_join(donald_trump_df) %>%
  left_join(mask_use_df, by = c("county_fips" = "COUNTYFP")) %>%
  left_join(vaccine_hesit_df, by = c("county_fips" = "FIPS.Code")) %>%
  left_join(death_count_df, by = c("county_fips" = "FIPS.County.Code"))





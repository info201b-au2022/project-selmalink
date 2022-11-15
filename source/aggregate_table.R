library(tidyverse)

mask_use_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/mask-use-by-county.csv")
mask_use_df <- mask_use_df %>%
  mutate(some_times_to_always = SOMETIMES + FREQUENTLY + ALWAYS, never_to_rarely = NEVER + RARELY) %>%
  select(c("some_times_to_always", "never_to_rarely", "COUNTYFP"))

death_count_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Provisional_COVID-19_Death_Counts_in_the_United_States_by_County.csv")
death_count_df <- death_count_df %>%
  select(c("FIPS.County.Code", "Deaths.involving.COVID.19"))

vaccine_hesit_df <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/data/Vaccine_Hesitancy_for_COVID-19__County_and_local_estimates.csv")
vaccine_hesit_df <- vaccine_hesit_df %>%
  mutate(total_unsure_to_hesitant = Estimated.hesitant + Estimated.hesitant.or.unsure + Estimated.strongly.hesitant) %>%
  select(c("FIPS.Code", "State", "total_unsure_to_hesitant"))

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

state_population_df <- read.csv("https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/totals/co-est2021-alldata.csv")
state_population_df <- state_population_df %>%
  filter(STNAME == CTYNAME) %>%
  mutate(cap_state = toupper(STNAME)) %>%
  select(c("cap_state", "POPESTIMATE2021"))

# merging all data frames
final_df <- joe_biden_df %>%
  left_join(donald_trump_df) %>%
  left_join(mask_use_df, by = c("county_fips" = "COUNTYFP")) %>%
  left_join(vaccine_hesit_df, by = c("county_fips" = "FIPS.Code")) %>%
  left_join(death_count_df, by = c("county_fips" = "FIPS.County.Code"))

# Creating aggregate table
final_aggregate_df <- final_df %>%
  group_by(State) %>%
  summarize(
    total_votes = sum(totalvotes, na.rm = TRUE), 
    biden_total = sum(biden_total_votes, na.rm = TRUE), 
    trump_total = sum(trump_total_votes, na.rm = TRUE), 
    low_mask = mean(never_to_rarely, na.rm = TRUE) * 100, 
    vaccine_hesitant = mean(total_unsure_to_hesitant, na.rm = TRUE) * 100, 
    total_deaths = sum(Deaths.involving.COVID.19, na.rm = TRUE)
    ) %>%
  ungroup() %>%
  drop_na() %>%
  left_join(state_population_df, by = c("State" = "cap_state")) %>%
  mutate(deaths_per_100000 = (total_deaths/POPESTIMATE2021)*100000,
         biden_percent = (biden_total/total_votes) * 100,
         trump_percent = (trump_total/total_votes) * 100
         )

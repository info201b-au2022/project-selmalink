library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(GGally)

source("https://raw.githubusercontent.com/info201b-au2022/project-selmalink/main/source/scatterplot_matrix.R")

choice_names <- colnames(matrix_df)
x_input <-  selectInput("x_var", label = h3("Select X Variable"), choices=choice_names)
y_input <- selectInput("y_var", label = h3("Select Y Variable"), choices=choice_names)


intro_panel <- tabPanel(
  "Introduction",
  h1("COVID-19 in Correlation to Politics"),
  img(src = "https://raw.githubusercontent.com/info201b-au2022/project-selmalink/fbd0af81e63cfe5590bf82e7d6f53e6aced4e4f9/source/covid19-cdc.png", height="75%", width="75%"),
  p("This report will distinguish the correlation between political leaning and containment and neutralization of the COVID-19 virus. Since its discovery in late 2019, COVID-19 has been a growing issue and evaluating the success of efforts to contain it is an important issue. To identify similarities between politics and neutralization efforts multiple points of data will be analyzed. The key goal of the visualization is to let viewers examine how political beliefs impact vaccination hesitancy, state policy regarding covid, and death counts. Despite its emphasis on factual data gathering and analysis, public health has developed into a more contentious political topic during the last few years. With the help of our study, we aim to discover a connection between political ideology, precautions taken, and covid outcomes.")
)

second_panel <- tabPanel(
  "Covid Deaths by State",

    sidebarLayout(
      sidebarPanel(
              sliderInput("mindepth", "Min depth:", min = 0, max = 500, value = 0),
              sliderInput("maxdepth", "Max depth:", min = 0, max = 500, value = 500)
        ),

     mainPanel(
      plotOutput("plot")
    )
  )
)


third_panel <- tabPanel(
  "Mask Usage by State",
  selectInput("state", label = h3("Select State"),
              choices = toupper(state.name)),
  plotOutput("piechart")
)

fourth_panel <- tabPanel(
  "Scatter Plots by Variables",
  x_input,
  y_input,
  plotOutput(outputId = "scat_plot")
)

fifth_panel <- tabPanel(
  "Summary Takeaways"
)

sixth_panel <- tabPanel(
  "Report",
  fluidPage(
  # Project Title
  h1("Political Leaning in Correlation with COVID-19 Outcomes"),
  #Authors
  h3(strong("Authors:"), em("Ben Leland blelan@uw.edu, Krithik Duraisamy durakrd@uw.edu, Valerie Lam vlam317@uw.edu, Selma Link slink3@uw.edu")),
  #Code Name
  p(strong("Code Name:"), "Purple Soup"),
  #Affiliation
  p(strong("Affiliation:"), "INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
  #Date
  p(strong("Date:"), "December, 2022"),
  # Abstract
  h3("Abstract"),
  p("Our main question is how do political ideologies affect the containment and neutralization of the COVID-19 virus. This is an important question because discovering the effectiveness of political decisions to contain COVID-19 and how imperative it is to learn the effects it has had on the public population. To address this question, we will analyze state policies regarding COVID, public vaccine hesitancy, and death counts resulting from COVID."),
  #Keywords
  p(strong("Keywords:"), "COVID-19; political leaning; vaccine hesitancy; prevention measures; death count."),
  # Introduction
  h3("Introduction"),
  p("Covid 19 has been a prominent issue for the world in the last two years. With the total number of deaths reaching about 7 million worldwide, covid 19 has been characterized as one of the worst pandemics in modern human history. As it finally dwindles down in 2022, data regarding death counts, vaccine rates/hesitancy, etc. have been gathered in substantial numbers. For our project we aim to analyze how political views affect vaccine hesitancy, state policy regarding covid, and death counts. In the past few years, public health has increasingly become a divisive political issue despite its reliance on factual data collection and analysis. With our analysis, we hope to identify a correlation between political ideology, precautions taken, and covid outcomes."),
  # Problem Domain
  h3("Problem Domain"),
  p(strong("Project Framing:"), "Create data visualizations for each dataset and use political affiliations as the factor that ties them all together."),
  p(strong("Human Values"), "Political beliefs and health/longevity. Political values/beliefs influence all the covid 19 outcomes the project analyzes. Political values usually originate from family, religion, location of residence, gender, etc. People with differing political values will take different actions regarding covid 19, which affects data outcomes. For example, according to the Pew research center", em("republicans are more likely to see Covid 19 as a minor threat opposed to a severe threat"), "(Tyson, 2020) which will directly affect what actions are taken in order to combat covid 19. Health and longevity are also a prominent value. When prioritization of health is apparent, people will take further action in maintaining it. In the datasets we analyze what actions states/people took in order to maintain health. Value tensions regarding health may include differing opinions on how one should maintain health (ie: holistically, surgically, medication, etc.)."),
  strong("Direct/Indirect Stakeholders:"),
  p("-", em("Direct"), ": healthcare professionals, US residents."), 
  p("-", em("Indirect"), ": local/federal government, politicians, vaccination companies."), 
  p(strong("Possible Harms and Benefits:"), "One potential benefit from this analysis is the ability to determine how successful a public health intervention might be in certain demographics within the US. A potential harm from our analysis is that third party actors could use the information to target advertising or scams towards specific demographics. Misleading advertising and scams could target susceptible populations based on political leaning and county location data for increased efficacy and damage."),
  # Research Questions
  h3("Research Questions"),
  strong("1. How does political leaning affect vaccine hesitancy  rates on a county level basis?"),
  p("Throughout the course of the COVID-19 pandemic, it was well known that political affiliation played a major role in vaccine hesitancy. Most people tend to conform to the social expectations around them. Identifying a correlation between 2020 election data results and vaccine hesitancy may expose the extent to which social expectations play a role in public health efficacy."),
  strong("2. How does political leaning affect mask usage on a county level basis?"),
  p("In the US, mask usage became a largely divisive issue drawn along ideological differences. Identifying a correlation between the two could allow for a greater understanding of how public health policies failed to adhere among certain demographics. Additionally, identifying a correlation between mask usage and covid mortality rates may provide a greater understanding of how ideology worsened COVID-19 outcomes."),
  strong("3. How does political leaning correlate with death rates/death counts on a county level basis?"),
  p("This question aims to identify how political leaning and rhetoric may have severally harmed counties and communities. Comparing election results on a county level will help identify how ideology may have influenced recklessness throughout the course of the pandemic."),
  # The Dataset
  h3("The Dataset"),
  img(src = "https://github.com/info201b-au2022/project-selmalink/blob/fbd0af81e63cfe5590bf82e7d6f53e6aced4e4f9/source/The-Dataset.jpg?raw=true", height="75%", width="75%"),
  #
  p(strong("Vaccine Hesitancy for COVID:"), "One of the main covid outcomes the project analyzes is hesitancy. The data from political leaning is in direct correlation with what counties are less/more hesitant. Higher hesitancy might be in relation to a stronger political party or vice versa."),
  p(em("(a)"), "The data was collected by the CDC, The Center for Disease Control and Prevention. Data was collected from April 9, 2021 to June 17, 2021. The purpose is to analyze covid vaccine hesitancy on a county level."),
  p(em("(b)"), "The CDC is funded federally, so data collection from surveys were funded federally. The government and citizens of the US are likely to benefit from the data. In terms of profit, the government will likely profit in some way."),
  p(em("(c)"), "The CDC has information guidelines in place that ensure quality and personal privacy of data. Yes, the CDC is credible. Data was obtained by researching datasets in relation to covid. Data sources came from surveys funded and affiliated by the government thus, very credible."),
  #
  p(strong("COVID Policies for States/Counties:"), "Political leaning, covid rates, etc. are all factors that influence what policies and regulations counties have. The more restrictions set for counties, the more the county might be affiliated with one political party that characterizes Covid as an extreme problem (not minor). Consequently more restrictions are put in place."),
  p(em("(a)"), "Data was collected from global data and survey firm Dynata through a series of online interviews. This data was utilized by the New York Times. Data collected from July 2 to July 14 (assuming year was 2020 since the article was written then). The purpose of this dataset is to highlight mask use of each county."),
  p(em("(b)"), "Data collected effort funded by the Canadian Pension Plan Investment Board. New York Times profits off the data because of the use of it in their article. As well as the government."),
  p(em("(c)"), "How was the data validated and held secure? Dynata validates the quality of their data by using digital identity validation. Yes dynata is credible due to the New York Times using the data from them as well."),
  p(em("(d)"), "Data was obtained by a search engine. Yes, the source of data is credible."),
  #
  p(strong("Death Counts from COVID:"), "The policies counties have in place and vaccination rates influenced by political leaning, directly affect mortality rates."),
  p(em("(a)"), "Data collected by the Department of public health. Data collection beginning June 16 2022 till the present. Purpose is to determine the death counts for each county over time."),
  p(em("(b)"), "The data collection is funded by federal grants. The government is likely to benefit from this data collection."),
  p(em("(c)"), "The Conneticute open data site has a series of legal and ethical steps it takes to validate data so it can be used on their website. Yes, the Connecticut open data site is credible."),
  p(em("(d)"), "By looking up covid death rates on the google search engine. Data source is credible because it came from the department of public health."),
  #
  p(strong("Political Leaning for State/Counties:"), "The project analyzes how political leaning/affiliation affects covid outcomes. Moreover, In order to determine if political leaning does have an effect on covid outcomes, it is essential to know election results for each county."),
  p(em("(a)"), "Data was collected by Harvard dataverse, and the author is MIT Election Data and Science Lab.This dataset contains county-level returns for presidential elections from 2000 to 2020."),
  p(em("(b)"), "The data collected effort is funded by New Initiatives in Election Science Program, giving a total amount of just under $100,000 for this round of New Initiatives Grants. The purpose of this dataset is to keep track of county presidential returns. Everyone, especially the government is likely to benefit from the data."),
  p(em("(c)"), "Since data gathered for analytics must be trusted, MIT itself is already respectable, as is their data. It is also reliable because the New York Times is also using MIT's data."),
  p(em("(d)"), "Data was obtained from the search engine Google, yes the source of data is credible."),
  # Expected Implications
  h3("Expected Implications"),
  p("Findings from the datasets and the project in general can assist scientists and policymakers. Utilizing datasets to make the project analyze work for covid 19 data and analysts that examine the number of deaths anticipated the absence of the pandemic. As the overall number of fatalities is probably more accurate than the total number of deaths from certain causes, examining higher-than-expected deaths from all causes aid in addressing shortcomings in the reporting of COVID-19 deaths."),
  # Limitations
  h3("Limitations"),
  p("The limitations of the datasets are as follows:"),
  p("1. A limitation shown in the data is that it does not solely focus on how policies directly affected the public. The only way to find that information is to correlate one dataset with another and infer the knowledge. There is no concrete evidence of how political leanings affected COVID rates and deaths."),
  p("2. Another limitation is the possibility of misinformation being funneled into the datasets. There are reports of false positive COVID cases and deaths being labeled as being caused by COVID. This information skews the datasets and limits the validity of data and analysis. To fix this we must validate the sources and ensure it is reliable data."),
  p("3. A final limitation of the datasets is that it focuses on the general public, it does not take into account race, ethnicity, gender, financial status. This could lead to missing data in the sets. To fix this limitation we must find more specific datasets or find further data on the current dataset."),
  # Findings
  h3("Findings"),
  p("1. "),
  p("2. "),
  p("3. "),
  # Discussion
  h3("Discussion"),
  p(""),
  # Conclusion
  h3("Conclusion"),
  p(""),
  #References
  h3("References"),
  p("- Vaccine Hesitancy for COVID-19: County and local estimates. (2021, June 17). Retrieved from", a("https://data.cdc.gov/Vaccinations/Vaccine-Hesitancy-for-COVID-19-County-and-local-es/q9mh-h2tw", href = "https://data.cdc.gov/Vaccinations/Vaccine-Hesitancy-for-COVID-19-County-and-local-es/q9mh-h2tw"), "."),
  p("- albertsun. (2020, July 28). mask-use-by-country. Retrieved from", a("https://github.com/nytimes/covid-19-data/blob/master/mask-use/mask-use-by-county.csv", href = "https://github.com/nytimes/covid-19-data/blob/master/mask-use/mask-use-by-county.csv"), "."),
  p("- MIT Election Data and Science Lab, 2018, County Presidential Election Returns 2000-2020,", a("https://doi.org/10.7910/DVN/VOQCHQ, Harvard Dataverse, V10, UNF:6:pVAMya52q7VM1Pl7EZMW0Q== [fileUNF]", href = "https://doi.org/10.7910/DVN/VOQCHQ, Harvard Dataverse, V10, UNF:6:pVAMya52q7VM1Pl7EZMW0Q== [fileUNF]"), "."),
  p("- ", a("https://www.kff.org/coronavirus-covid-19/poll-finding/importance-of-partisanship-predicting-vaccination-status/", href = "https://www.kff.org/coronavirus-covid-19/poll-finding/importance-of-partisanship-predicting-vaccination-status/"), "."),
  p("- Provisional COVID-19 Death Counts in the United States by County. (2022, October 26). Retrieved from", a("https://data.cdc.gov/NCHS/Provisional-COVID-19-Death-Counts-in-the-United-St/kn79-hsxy", href = "https://data.cdc.gov/NCHS/Provisional-COVID-19-Death-Counts-in-the-United-St/kn79-hsxy"), "."),
  p("- ", a("https://www.pewresearch.org/fact-tank/2020/07/22/republicans-remain-far-less-likely-than-democrats-to-view-covid-19-as-a-major-threat-to-public-health/", href = "https://www.pewresearch.org/fact-tank/2020/07/22/republicans-remain-far-less-likely-than-democrats-to-view-covid-19-as-a-major-threat-to-public-health/"), "."),
  #Apendix A
  h3("Apendix A: Questions"),
  p("1. No Questions")
  )
)

ui <- fluidPage(
    navbarPage(
      title = "Covid 19 and Political Leaning",
      intro_panel,
      second_panel,
      third_panel,
      fourth_panel,
      fifth_panel,
      sixth_panel
    )
  )
  


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
  "Summary Takeaways",
  h3("First takeaway"),
  
  p("As seen from the histogram depicting covid deaths for each state, The state that has the most COVID deaths per 100,000 people is Mississippi. Mississippi has about 472.6836 deaths per 100,000 people. The state that has the least amount of COVID deaths per 100,000 people is Alaska. Alaska has about 50.67301 deaths per 100,000 people. With these observations, states with larger populations located in the southern region of the US have more COVID deaths, opposed to states with smaller populations located elsewhere in the US. It seems that southern states tend to have more covid doubts and relaxed covid restrictions due to conservative/republican values that are very prominent in southern states."),
  
  h3("Second takeaway"),
  
  p("The pie chart calculates the mask usage proportions in the U.S. for each state by people's frequency of wearing masks. Frequency: never, rarely, sometimes, frequently and always. The state with the highest rate of never wearing a mask is North Dakota with 18% of residents never wearing a mask. All of the other frequencies for North Dakota also fall around the range of 20%. The states with the highest mask usages are Hawaii and Delaware, with 82% of residents always wearing a mask when in public. From this data, we can conclude that mask usage is dependent on state policy. Although some southern states may have more relaxed rules about wearing a mask, other states throughout the U.S. also do."),
  
  h3("Third takeaway"),
  
  p("From the Scatter plot we can determine the mask usage, the vaccine hesitancy, and deaths per 100,000 from Biden supporters and Trump supporters. The scatter plot highlights that Biden supporters will more often have a higher mask usage, a lower vaccine hesitancy, and lower deaths per 100,00 people rate. For Trump supporters the mask use is often lower, the vaccine hesitancy is higher, and the deaths per 100,000 is higher as well. From this data, we can conclude that Biden supporters will follow higher state regulations which inturn will have lower detrimental Covid outcomes. In regards to Trump supporters and the relative location of their residence (south), Covid restrictions are lower which in turn contribute to higher death rates.")
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
  p("1. Political leanings affect vaccine hesitancy rates in a way that was expected. The expected outcome was that states and counties that leaned more red/republican would be more hesitant to take the vaccine in comparison to those on the blue/democrat side. In our question, we deduced that people tend to conform to society around them. This is the case after reviewing the data because most people chose to believe in the vaccine based on their political leanings due to it being mainly surrounding their society. The 2020 election nearly ended with republican Donald Trump as president which helps to explain why there was high hesitancy in taking the COVID-19 vaccine."),
  p("2. Similar to vaccine hesitancy, our team hypothesized that there would be a high correlation between political leanings and mask usage by county. This was especially evident, as counties that were labeled by majority republicans chose to refuse and not wear a mask on average. On the other hand, those who leaned farther left than right conformed to the mandate that masks had to be worn and wore their masks farther towards the “always” side of the graph compared to the other republican side that leaned farther towards the “never” side. The public health policies that helped to reduce the amounts of deaths by using masks were split between both political groups, where republicans on average chose to wear masks less and in contrast, democrats chose to use masks more often than not."),
  p("3. As was evident in the previous two correlations, the same can be said about death rates and counts on a county level basis. In the 2020 election it was proven that even though the republican candidate Donald Trump won the presidency, on average the American population leaned farther towards a democrat majority. This data proves evident that those who chose to wear masks from the mandate died much less often in comparison to those who did not wear masks. The correlation between mask usage and death rates is very high, this says that those who chose to not wear masks on average died at much higher rates due to the infectious nature of COVID-19."),
  # Discussion
  h3("Discussion"),
  p("There are several important implications from the findings of the study. The findings demonstrate an overall decline in adhering to public health safety measures among conservatives. The findings on political leaning corresponding to vaccine hesitancy is indicative of this trend. Rhetoric during the 2020 presidential campaigns, specifically relating to vaccines, was highly charged and evocative. The rhetoric and media people were exposed to and believed in greatly affect their views on vaccine efficacy. Despite public health officials claiming the vaccines were safe, conservatives firmly believed that they were not worth taking. Similar to vaccine hesitancy, mask usage was also heavily polarized. Mask recommendations, which were also highly supported by public health officials, were disregarded primarily by conservatives. States with higher  proportions of votes for Trump had more people refusing to wear masks. The opposite trend was observed for states that had higher proportion of the population voting for Biden. A consequence of these trends is higher death rates among states that had higher proportion of voters voting for Trump. Additionally, states with low mask usage and high vaccine hesitancy had slightly higher covid death rates. This indicates how political rhetoric during the 2020 presidential election indirectly affected health outcomes. Americans who supported Trump were more likely to follow social norms that disregarded public health measures intended to protect them. Public health officials in the future must take political leaning into account when creating health policy and measures. Despite its roots in factual analysis, public health has increasingly become a contested field due to political rhetoric. Long term negative health affects from covid are not as well understood, but are an increasing concern, Consequently, in the future, conservatives may suffer worse health outcome due to higher rates of covid infection."),
  # Conclusion
  h3("Conclusion"),
  p("COVID-19 has been a rampant infection that has spread from country to country killing millions worldwide. In order to understand its effects that it has had on the US population multiple factors were considered. The political leanings of the population were used to correlate with other data such as vaccine hesitancy, mask usage, and overall death count. This data was distinguished between each county in the US to find exact correlations in small communities. The findings showed that on average those who leaned farther right towards republican chose to take the vaccine less, wear masks less, and because of these factors died more frequently due to COVID. In contrast, those who leaned farther left towards democrat chose to on average take the vaccine more, wear masks more often, and because of this died far less than those who did not take the vaccine and not wear masks. The public health policies that attempted to protect the public only worked when people chose to follow the mandates that were put in place. To answer the question that we asked if there was a correlation between political leanings and the containment and neutralization of the COVID-19 virus, yes. There is a strong correlation that those who leaned closer to the democrat side followed the mandates made by the government in containing the virus and were successful in doing so. The mandates were not successful in containing the virus when people chose to not follow the mandated rules in how to protect others and yourself in public and because of this the data shows that people died more often because of that. We have deduced that if the population that chose to not wear masks and get the vaccine did the opposite the data would be much lower in death counts. The world can not be perfect however, so this would not be possible, but finding a correlation between factors that cause deaths and why this happens is essential to stopping another pandemic in the future."),
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
  


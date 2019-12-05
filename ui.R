# Please install (PLEASE UNCOMMENT AND INSTALL)
# install.packages("maps")
# install.packages("mapproj")

# Please setwd to your own working directory!
# setwd()

# Used libraries, don't forget to install packages on each local
library("shiny")
library("shinythemes")
library("dplyr")

source("functions.R")


# Renamed column names
desired_columns <- data_2017 %>%
  select(CapitaGDP, Family, LifeExpectancy, Freedom, Generosity, Government)



# Shiny UI
shinyUI(navbarPage(title = "Global Happiness Report",
                   theme = shinytheme("darkly"),
                   # Intro Tab
                   tabPanel("Introduction",
                   fluidPage(
                     h2("Introduction"),
                     p("Happiness is one of the hardest amenities on the planet to quantify. Money can't buy
                       it. Goods cannot be bartered for it. It cannot be grown or mined like a natural resource.
                       It simply exists. The purpose of this analysis is to identify where in the world happiness
                       is most plentiful, and what, if any, factors can be correlated to its existence. Our goal
                       is for our visualizations to point out underlying patterns that accompany happiness, with
                       the hope that individuals can use the information in their decision-making in order to
                       maximize their personal happiness. In the long-run, our hope is that this will raise 
                       collective happiness as well, resulting in a positive impact even on individuals who do not
                       view our analysis."),
                     p("Happiness is nearly impossible to measure objectively, and varies across individuals,
                       societies, and nations. This makes it difficult to perform statistical analysis on. Because
                       of this, our chief problem in working with happiness is finding a way to quantify an
                       emotional experience. There can be no doubt that finding a way to measure happiness, and its 
                       influencing factors is of utmost importance to many people, and of great interest to many others.
                       If we are able to sucessfully identify what correlating factors accompany happiness in different
                       situations, the findings should be valuable to every global citizen."),
                     p("In order to complete this task in a way that pays respects to the diversity of the global
                       population, we must first acknowledge that influential factors on happiness will vary across
                       geographical and chronological bounds. To account for this, we will utilize a variety of data
                       visualizations with discrete objectives that represent happiness in the different forms it
                       appears in. These visualizations will include scatterplots, heatmaps, and dot-distribution maps,
                       which focus on isolating happiness as it correlates to selected independent factors, regional
                       bounds, and across multi-year spans. The visualizations will allow individuals to easily view
                       thousands of pieces of data, and identify patterns existing within.")
                   )
                   ),
                   # First tab
                   tabPanel("Global Happiness",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Influential Factors on Global Happiness"),
                                sidebarPanel(
                                  selectInput("Feature", "Please Select Feature to Compare",
                                              choices = colnames(desired_columns)),
                                  h4("Top 3 Most Important Factors to Happiness w/R-squared score:"),
                                  p("GDP per Capita: 0.658"),
                                  p("Life Expectancy: 0.609"),
                                  p("Family: 0.564"),
                                  h4("Least Important Factor in Happiness:"),
                                  p("Generosity: 0.017")
                                ),
                                mainPanel(
                                  plotOutput("myPlot"),
                                  h3("What We Learned"),
                                  p("By plotting happiness scores of the 155 countries 
                                    on the y-axis
                                    and plotting the 6 key attributes on the x-axis, we
                                    were able to use linear regression to determine the
                                    coefficient of determination (R-squared), the y-intercept,
                                    the slope, and the p-value."),
                                  p("With these statistics, we were able to learn many things
                                    about the global patterns of the 155 data points. What we
                                    wanted to focus on, is the value of the coefficient of
                                    determination, also known as R-squared. This determines
                                    the variance in the data, the higher the number, the
                                    closer the points are to the fitted line.
                                    In other words for our data, the larger the
                                    value, the more correlation there is between global happiness
                                    and that specific feature."),
                                  p("To add, the extremely low p-values indicate strong evidence
                                    of our data, meaning that it is statistically unlikely that
                                    our data is inaccurate due to factors such as luck."),
                                  p("What surprised us was how low of a correlation there is between
                                    happiness scores and generosity. A \"R-squared\" score of just
                                    0.017726 shows that there is barely any correlation, which
                                    is shocking. The highest two factors were GDP and Life Expectancy,
                                    which was predictable since those factors are related to
                                    a person's general quality of life.")
                                )
                              )
                            )
                   ),
                   
                   # Tab 2
                   tabPanel("Happiness by Region",
                            shinyServer(
                              pageWithSidebar(
                                headerPanel("Regional Influence on Global Happiness"),
                                sidebarPanel(selectInput("Feature_2", "Please Select Feature to Compare",
                                                         choices = desired_columns2
                                ),
                                selectInput("region_list", "Please Select Region",
                                            choices = region
                                )
                                ),
                                
                                mainPanel( plotOutput("regionalPlot"),
                                           h3("What We Learned"),
                                           p("In plotting the happiness scores of all the countries in 2017, we noticed
                                  that regions definitely play a part in the country's happiness score overall.
                                  As we can see, the happiest regions on average were those from the North American
                                  and European regions, with countries like Norway, and Canada leading
                                  the rankings for their respective regions. Sadly, we also found that the unhappiest
                                  regions tended to lie in the Middle East and South America, likely resulting from
                                  the significant poverty and war on terrorism these regions deal with, as these regions
                                  on average contained significantly lower Health Life Expectancy scores and Freedom
                                  scores as well."),
                                           p("It was important to note that there were specific factors that carried these
                                  specific regions' happiness scores than others. For example, in North America
                                  factors such as Generosity and EconomyGDP per Capita for the US and Canada 
                                  were on average higher than countries from other Regions like Asia, South America
                                  and Africa which could be due in part to the specific culture and economic
                                  standing entailed with these regions as opposed to others with a possibly smaller
                                  product markets to support them."),
                                           p("Lastly, it is crucial in understanding the data to recognize the amount of countries
                                  residing in each specific region. Some regions such as North America and Australia  
                                  contain a significantly less amount of countries and with that poll data, 
                                  and so drastically different numbers for these regions would tip them above or lower
                                  than more populated regions. It was also interesting to see the regional distribution
                                  of data that pertained to regional happiness, with some regions having lower numbers
                                  all around for certain factors such as Trust in Government or Life Expectancy"
                                           )
                                )
                              ))),                   
                              # Tab 3
                              tabPanel("Happiness Over Time",
                                       shinyServer(
                                         pageWithSidebar(
                                           headerPanel("Global Happiness Heatmap"),
                                           sidebarPanel(
                                             selectInput("Year", "Please Select a Year",
                                                         choices = c("2015", "2016", "2017")),
                                             htmlOutput("heatmapText")
                                           ),
                                           mainPanel(
                                             plotOutput("myHeatmap"),
                                             h3("What We Learned"),
                                             p("By plotting the happiness scores of over 150 countries over the span
                                    of three years, 2015-2017, we were able to quickly visualize patterns
                                    that appeared in the data. Almost immediately, it became apparent that
                                    the happiest nations tended to reside in North America and Western Europe,
                                    while the unhappiest nations were typically found in Afica and Southeast
                                    Asia. This is consistent with the results from our influential factors 
                                    scatterplots, as countries in North America and Western Europe tend to 
                                    have much higher GDP per capita and Life Expectancies then their African
                                    and Southeast Asian counterparts."),
                                             p("While we were only working with a 3-year sample size, we were still
                                    surprised by the lack of change in happiness scores over time. Looking
                                    at the different heatmaps, it can be difficult to notice change on a year-
                                    to-year basis, which we attributed to the fact that societies rarely
                                    experience large shifts in collective happiness without a 'trigger' of some
                                    sort. One interesting fact we discovered is that after the controversial
                                    election of President Trump in 2016, the United States' happiness score fell",
                                               strong("below"), "7.00 for the first time in the three year span we measured."),
                                             p("A final takeaway when looking at happiness scores over time: pay attention to
                                    the Scandinavian countries. Denmark, Switzerland, Iceland, and Norway all
                                    ranked in the top 5 for overall happiness in every year we measured. Finland was
                                    also ranked in the top 5 in two of the three years we measured. In fact, the only
                                    non-Scandinavian country to crack the top 5 was Canada, in 2015. While our study
                                    does not allow us to make causation-based claims, all 5 countries are run similarly
                                    with regards to economic structure, and government welfare policies. The top 5
                                    unhappiest countries list was a little more volatile, as only Burundi and Syria
                                    were ranked all three years. Syria's place can most likely be attributed to the
                                    ongoing civil war currently afflicting the nation, while Burundi is widely
                                    considered unsafe due a rise in terrorism and violent crime.")
                                           )
                                         )
                                       )
                              ),
                              
                              # Tab 4
                              tabPanel("Top Ten Map",
                                       shinyServer(
                                         pageWithSidebar(
                                           headerPanel("Top Ten"),
                                           sidebarPanel(
                                             selectInput("t4_year",
                                                         label = h3("Select Year"),
                                                         choices = year_list,
                                                         selected = "2017"
                                             ),
                                             selectInput("t4_category",
                                                         label = h3("Select Category"),
                                                         choices = category_list("2017"),
                                                         selected = "")),
                                           mainPanel(leafletOutput("map"),
                                                     h3("Analysis"),
                                                     p("Applying the categorical observation of each country into
                                            a geographical map, gave a sense of the strength of each 
                                            attribute dependent upon the area. In 2017, the attribute 
                                            generosity for example, was predominantly found within Asian 
                                            and Oceanic countries. When we compare these results to the 
                                            overall highest happiness ranked countries, the top ten has 
                                            little relations with the generosity attribute. The top ten happy 
                                            countries do however show a stronger relationship with the top ten 
                                            countries with the attribute freedom. These type of observation
                                            helps find trends that corelate between the attribute and its 
                                            geographic location. "),
                                                     p("One of the biggest observations we recorded, was that most countries
                                            that are ranked top in happiness was found within the Europe.
                                            When observing GDP, the Middle East had a strong presence within the
                                            top ten ranks. These types of observation are fascinating as we were
                                            able to discover a country such as the United Arab Emirates (UAE), to 
                                            find GDP a strong factor in happiness. Understandable as the UAE holds 
                                            the second largest GDP in the Arab countries."),
                                                     p("When we compare results in factors of years, it becomes difficult 
                                            to see any changes between time. Although we only observed through
                                            a span of three year, there was little to no change in the geographical
                                            movement of each category. We do however noticed pockets of countries.
                                            For Example, when observing dystopia, through all three years, many of
                                            the countries remained within Central America. These 'pockets' of countries
                                            are found easily throughout all the categories, and it becomes surprising that
                                            they tend to remain within their designated area. "))
                                         )
                                       )
                              ),
                              tabPanel("About",
                                       shinyServer(
                                         fluidPage(
                                           h2("About Us"),
                                           h3("Pasit Areepipatkul"),
                                           p("I am a 2nd year student at the University of Washington, intended to study 
                                             Informatics and Computer Science. With this group project in my INFO-201 class 
                                             on data science, I was excited to propose the idea of working on a dataset that 
                                             focuses on the trends of world happiness. As soon as we were all on board, we 
                                             utilized the R-language skills we learned from class to successfully build a web
                                             application that analyzes the data derived from the World Happiness Report. With 
                                             this project, I got to work in a small team environment and used tools such as Git, 
                                             something I was previously acquaintanced with during my software engineer internship 
                                             during the summer. Therefore, I tried to transition these coding skills over for the 
                                             benefit of the team and assisted them with any tasks that came up."),
                                           p("I was responsible for the first tab in our application, where I tried using linear 
                                             regression and the coefficient of determination to find the strongest correlation 
                                             between happiness and one of the six features (GDP, freedom, life expectancy, etc). 
                                             What I found was quite remarkable - how insignificant the correlation is between 
                                             generosity and happiness scores. Despite the reasoning behind this, it is quite 
                                             difficult to see that generosity had the lowest correlation out of all the features. 
                                             Born and raised in Bangkok, Thailand - I was often taught that giving was an essential
                                             component to life, and how fulfilled you can feel inside when you share something with
                                             others (however, I’m still proud that Thailand ranks as one of the top countries for 
                                             generosity in this data set)."),
                                           p("I believe this is the beauty of Informatics, where I can combine my own passion of 
                                             technology with the humanities side to see the current failures of society, and hope to 
                                             study how I can optimize future technologies to ethically-impact society for the better."),
                                           h3("Welson Nguyen"),
                                           p("I am currently a student at the University of Washington as a junior. My intended major 
                                             of study is Informatics and Computer Science with a focus in cyber security. This project 
                                             is a work done under the INFO-201 course. Here we use the R-studio language to wrangle and 
                                             analyze sets of data in a collaborative environment that encapsulates the use of technology 
                                             in information analyzation. This specific project code named Utopia, contains my efforts in 
                                             coding collaboratively with others, analyzing data provided by the United Nations World 
                                             Happiness Report. Using Git, GitHub, R-studio, Excel, and critical thinking skills, our 
                                             team sought after trends found within the provided data. My role besides coding was to help 
                                             in areas the team required assistance. From analyzing data, backup coder, or general hand, 
                                             I took the responsibility to support my team in any way I am able to make our team successful. 
                                             As tasks are divided between members, mine being the “Top Ten Map” tab,  there was always work 
                                             that needed an extra support outside of my own responsibility."),
                                           h3("Rahul Prasad"),
                                           p("I am currently a junior at the University of Washington, intending to pursue a double major
                                             in Economics and Informatics. I have always been a proponent of living a life that keeps you
                                             both challenged and fulfilled, and so the opportunity to analyze happiness trends was an 
                                             experience I am truly grateful for. I was responsible for developing the code that created
                                             a happiness heatmap, which displayed global happiness scores for each country from 2015-2017.
                                             I used ggplot2 and dplyr packages in order to organize the data and create the visualization.
                                             When I am not wrangling data, I am either acting as the Co-President for TEDxUofW, the offical UW 
                                             TEDx Talks organization on campus, working for the Seattle Seahawks as a Street Team Member,
                                             or creating hip-hop music!"),
                                           h3("Geoffrey Cabatingan"),
                                           p("Greetings! My name is Geoffrey Cabatingan and I’m currently a second year student at the 
                                             University of Washington majoring in Geographic Information Systems double minoring in DXArts 
                                             (Digital Arts & Experimental Media) and Informatics. In terms of tech, I’m passionate about 
                                             improving overall efficiency and usability through providing context for and interpreting data. 
                                             Doing this project titled the “Global Happiness Report” has been a great exposure to using and 
                                             collaborating on Github: one of the most used professional programs for collaboration to this day. 
                                             Here, we were able to employ the R computer language to create statistical and spatial 
                                             visualizations of countries’ “happiness” rankings and scores based on many societal factors that 
                                             we analyzed from our 2015-2017 datasets."),
                                           p("We split the work up in this project by each doing our own visualizations, as we felt it would 
                                             be more convincing for results to implement all types of different graphs/maps to give a more 
                                             genuine and whole answer of what made people happy. In this project, I focused on the statistical 
                                             visual of regional happiness, creating an interactive scatterplot which allows users to identify 
                                             one of the six specific societal variables to compare with the countries’ happiness score. It was 
                                             interesting to see how regions ranked in terms of happiness, with North America and Western Europe 
                                             being on average higher than other regions. Studying Geography as well, I'm very pleased to have
                                             had the opportunity to combine both of my passions to create a positive and interactive report 
                                             for you all!"),
                                           h2("Learn More"),
                                           p("View our Technical Report Here:", 
                                                     a("Link to Wiki"),
                                                     href = "https://github.com/rahulgp12/uw-ischool-info-201a-2019-autumn-Project")
                                         )
                                       )
                              )
                            ))
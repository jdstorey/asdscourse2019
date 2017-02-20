# scrapped county level data from townhall.com
# original idea to scrape comes from https://github.com/tonmcg/County_Level_Election_Results_12-16/
# this version results in a dataset more appropriate for the course

library(tidyverse)
library(stringr)
library(rvest)

STATES <- c('AL','AK','AZ','AR','CA','CO','CT','DC','DE','FL',
            'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME',
            'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
            'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
            'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')

out <- list()

for( s in STATES ) {
  print(s)
  Sys.sleep(4/7) # be polite
  u <- paste0("http://townhall.com/election/2016/president/", s, '/county')
  html_in <- read_html(u)
  county_table <- html_in %>% 
    html_nodes(xpath="//*[@id=\"election-live\"]/table[2]") %>% 
    html_table(fill=TRUE) %>%
    .[[1]] 
  table_names <- county_table[1,]
  county_table <- county_table[2:nrow(county_table),]
  names(county_table) <- table_names
  county_table <- mutate(county_table, County=str_replace(County, "\\n.+$", ""))
  county_table <- county_table %>% 
    mutate(Votes=str_replace(Votes, "^-$", "0")) %>%
    mutate(Votes=str_replace_all(Votes, ",", "")) %>%
    mutate(Votes=as.integer(Votes))
  county_table <- county_table %>% rename(Percentage=`% Won`) 
  county_table <- county_table %>%
    mutate(Percentage=str_replace(Percentage, "^-$", "0.00")) %>%
    mutate(Percentage=str_replace(Percentage, "%$", "")) %>% 
    mutate(Percentage=as.numeric(Percentage))
  county_table <- mutate(county_table, State=s) %>% as_tibble
  out[[s]] <- county_table
}

DF <- bind_rows(out)

# problem 1: percentages don't necessary sum to 100. column adds no new information.
DF %>% group_by(State, County) %>% 
  summarise(s=sum(Percentage)) %>% 
  filter(s != 100)

# problem 2: no electoral votes. i'll copy paste from wikipedia
EV <- c(9,3,11,6,55,9,7,3,3,29,16,4,4,
        20,11,6,6,8,8,4,10,11,16,10,6,
        10,3,5,6,4,14,5,29,15,3,18,7,7,
        20,4,9,3,11,38,6,3,13,12,5,10,3)

DF <- DF %>% mutate(Electoral_votes=EV[match(State, STATES)])

# reorder columns

DF <- DF %>% select(State, Electoral_votes, County, Candidate, Votes)

write.table(DF, file="election_2016.txt", sep="\t", row.names=FALSE, col.names=TRUE, quote=FALSE)

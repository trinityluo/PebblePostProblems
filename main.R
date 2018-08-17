library(tidyverse)
library(ggplot2)

# load data
cookie_match <- readRDS('data/processed/cookie_match.Rds')
event <- readRDS('data/processed/event.Rds')

# find all matched events
matched_events <- event %>% 
  inner_join(cookie_match, by = c('ppid', 'date'))


# Question 1 --------------------------------------------------------------

# Q1-1, number of events/brand/day
num_events <- event %>% 
  count(brand_id, date)

# Q1-2, number of Matched events/brand/day
num_match_events <- matched_events %>% 
  inner_join(cookie_match, by = c('ppid', 'date')) %>% 
  count(brand_id, date)


# Question 2 --------------------------------------------------------------

# create new column for day of week
num_events <- num_events %>% 
  mutate(day = weekdays(date))

# calculate average events per day of week
avg_events_dayofweek <- num_events %>% 
  group_by(brand_id, day) %>% 
  summarise(avg_evnts = mean(n))

# plot
week <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
avg_events_dayofweek$day <- factor(avg_events_dayofweek$day, levels = week)

ggplot(avg_events_dayofweek, aes(x=day, y=avg_evnts, fill=brand_id)) +
  geom_bar(stat='identity', position=position_dodge()) +
  scale_fill_brewer(palette="Paired") +
  theme_minimal() +
  xlab('Day of week') + 
  ylab('Avg Events') +
  ggtitle('Average number of events for each Day of Week for each brand')


# Question 3 --------------------------------------------------------------



# Question 4 --------------------------------------------------------------

# create contingency table
mat <- matrix(c(500, 200, 10000, 5000), nrow = 2, 
             dimnames = list(c('test', 'control'), 
                             c('converted', 'not_converted')))
chisq.test(mat)

# p-value= 0.01001, reject nuLL hypothesis. It gives the strong evidence to suggest that test and control group have statistical significance difference.




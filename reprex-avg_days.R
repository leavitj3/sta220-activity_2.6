# reprex-avg_days.R
# Riley: the average days to close looks too low. Can anyone see why?

library(tidyverse)

claims_small <- tribble(
  ~claim_id, ~days_to_close,
  "X-001",               28,
  "X-002",               40,
  "X-003",               -1,
  "X-004",               -1
)

# I expected an average of 34 days, with half of the claims late.
# I get an average of 16.5 days and a share late of 0.25.
claims_small |>
  summarize(
    avg_days   = mean(days_to_close),
    share_late = mean(days_to_close > 30)
  )

# Step 1: Filter out open claims for duration/late calculations
df_clean <- df %>% 
  filter(days_to_close != -1)

# Step 2: Summarize by claim_type
summary_table <- df %>% 
  group_by(claim_type) %>% 
  summarize(
    Claims               = n(),
    Still_open           = sum(days_to_close == -1),
    Average_days_to_close = mean(days_to_close[days_to_close != -1]),
    Share_late           = mean(days_to_close[days_to_close != -1] > 30)
  )

library(tidyverse)

df <- read_csv("data/2025_q1.csv")

q1_summary <- df %>% 
  group_by(claim_type) %>% 
  summarize(
    Claims                = n(),
    Still_open            = sum(days_to_close == -1),
    Average_days_to_close = mean(days_to_close[days_to_close != -1]),
    Share_late            = mean(days_to_close[days_to_close != -1] > 30)
  )

q1_summary

summary_table <- df %>% 
  group_by(claim_type) %>% 
  summarize(
    Claims                = n(),
    Still_open            = sum(days_to_close == -1),
    Average_days_to_close = mean(days_to_close[days_to_close != -1], na.rm = TRUE),
    Share_late            = mean(days_to_close[days_to_close != -1] > 30, na.rm = TRUE)
  )

summary_table
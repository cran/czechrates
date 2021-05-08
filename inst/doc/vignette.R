## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(collapse = T, fig.align="center", dpi = 150, out.width = "100%", fig.width = 8, fig.height = 4, message = F)

## ----repo---------------------------------------------------------------------
library(czechrates)

# PRIBOR: relying on default for both date and tenor
pribor() 

# PRIBOR: specific date, default tenor
pribor(as.Date("2020-05-20")) 

# three specific dates + a specific tenor (weekly rate)
three_dates <- as.Date(c("2020-05-11", "2020-05-12", "2020-05-13"))
three_dates

pribor(three_dates, "1W")

# PRIBOR: four rates for a single date
pribor(as.Date("2020-05-20"), c("1D", "1W", "1M", "1Y")) 



## ----asian-fever--------------------------------------------------------------
library(czechrates)
library(ggplot2)
library(scales)

offered_rate <- pribor(seq(from = as.Date("1997-05-01"), 
                           to   = as.Date("1997-06-30"),
                           by = 1))

ggplot(data = offered_rate, aes(x = date_valid, y = PRIBOR_1D)) +
  geom_line(color = "red", size = 1.25) +
  scale_x_date(date_labels = "%d.%m.%Y") +
  scale_y_continuous(labels = percent_format()) +
  theme_bw() +
  labs(title = "A ghost of rates past...",
       y = "Overnight PRIBOR (per annum basis)") +
  theme(axis.title.x = element_blank())


## ----repo-rate----------------------------------------------------------------
# two-week REPO rate for yesterday
repo2w()

# two-week REPO rate for three specific dates (as defined in the PRIBOR section)
repo2w(three_dates)


## ----recent-development-ir----------------------------------------------------
library(czechrates)
library(ggplot2)
library(scales)

policy_rate <- repo2w(seq(from = as.Date("2020-01-01"), 
                          to   = as.Date("2020-05-31"),
                          by = 1))

ggplot(data = policy_rate, aes(x = date_valid, y = REPO_2W)) +
  geom_line(color = "red", size = 1.25) +
  scale_x_date(date_labels = "%d.%m.%Y") +
  scale_y_continuous(labels = percent_format()) +
  theme_bw() +
  labs(title = "COVID-19 impact on CZK policy rate",
       y = "ČNB REPO rate (per annum basis)") +
  theme(axis.title.x = element_blank())


## ----fx-rates-----------------------------------------------------------------
# complete list of ČNB FX rates for yesterday
cnbfxrate()

# EUR/CZK rate for three specific dates (as defined in the PRIBOR section)
cnbfxrate(three_dates, "EUR")


## ----recent-development-fx----------------------------------------------------
library(czechrates)
library(ggplot2)
library(scales)

euro_rate <- cnbfxrate(seq(from = as.Date("2020-01-01"),
                           to   = as.Date("2020-05-31"),
                           by = 1),
                       "EUR")

ggplot(data = euro_rate, aes(x = date_valid, y = rate)) +
  geom_line(color = "red", size = 1.25) +
  scale_x_date(date_labels = "%d.%m.%Y") +
  scale_y_continuous(labels = dollar_format(prefix = "",
                                            suffix = " CZK",
                                            accuracy = 1/100)) +
  theme_bw() +
  labs(title = "COVID-19 impact on CZK exchange rate",
       y = "ČNB EUR/CZK FX rate") +
  theme(axis.title.x = element_blank())



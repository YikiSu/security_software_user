# author: Zhanyi Su
# date: 2020-12-23

"This script takes in a feather file from the result folder and generate plots. At the end, save the plot data in a png file in the result folder.

Usage: eda.R --input=<input> --out_path=<out_path>

Options:
----input=<input>        The csv file to read in
--out_path=<out_path>    Path of where to locally save the feather file
" -> doc

library(docopt)
library(feather)
library(tidyverse)


opt <- docopt(doc)

main <- function(input, out_path) {
  
  data <- read_feather(input)
  
  #' Create average usage by each income group by each security software version
  #'
  #' @param sample data frame or tibble containing the data
  #'
  #' @return tibble containing the average usage by each groups
  #' @export
  #'
  #' @examples
  #' group_ft(data)
  group_ft <- function(sample){
    sample %>% 
      group_by(household_income_quartile) %>% 
      summarise(avg=mean(value, na.rm=TRUE))
  }
  
  # create the distribution plot for 2010
  nest_df <- data %>% 
    filter(ref_date == 2010) %>% 
    group_by(security_software_use) %>% 
    nest()
  
  group_df <- nest_df %>% 
    mutate(ave = map(data, ~group_ft(.)))
  
  # create a data frame for the average usage by each income group for paid version of security software
  user_df <- group_df$ave[[1]] 
  colnames(user_df) <- c("household_income_quartile", "General")
  
  # create a data frame for the average usage by each income group for free version of security software
  free_df <- group_df$ave[[2]] 
  colnames(free_df) <- c("household_income_quartile", "Free")
  
  
  combined_df <- left_join(user_df, free_df) %>% 
    mutate(Paid = General - Free) %>% 
    pivot_longer(-household_income_quartile, names_to = "type", values_to = "avg") 
  
  
  plot_df <- combined_df %>% 
    filter(type != "General") %>% 
    filter(household_income_quartile != "Total, household income quartiles") %>% 
    mutate(household_income_quartile=case_when(household_income_quartile == "Highest quartile household income" ~ "Highest quartile",
                                               household_income_quartile == "Lowest quartile household income" ~ "Lowest quartile",
                                               household_income_quartile == "Second quartile household income" ~ "Second quartile",
                                               household_income_quartile == "Third quartile household income" ~ "Third quartile")) 
  
  
  plot2010 <- ggplot(plot_df, aes(x=type, y=avg, fill=type)) + 
    geom_bar(stat='identity') +
    facet_wrap(~household_income_quartile, ncol=5, scales = 'free') +
    labs(title = "Average Usage of each security software usage by income group in 2010", 
         y = "Average Usage", 
         x = "Security Software Version") +
    theme(
      plot.title = element_text(face = "bold", size = 12),
      axis.title = element_text(face = "bold", size = 12),
      legend.position = "none",
      strip.text.x = element_text(face = "bold", size = 10)
    ) 
  
  # save the 2010 distribution plot into png files 
  ggsave(paste0(out_path, "/2010plot.png"), 
         plot2010,
         width = 8, 
         height = 10)
  
  # create distribution plot for 2012
  nest_df2 <- data %>% 
    filter(ref_date == 2012) %>% 
    group_by(security_software_use) %>% 
    nest()
  
  group_df2 <- nest_df2 %>% 
    mutate(ave = map(data, ~group_ft(.)))
  
  # create a data frame for the average usage by each income group for paid version of security software
  user_df2 <- group_df2$ave[[1]] 
  colnames(user_df2) <- c("household_income_quartile", "General")
  
  # create a data frame for the average usage by each income group for free version of security software
  free_df2 <- group_df2$ave[[2]] 
  colnames(free_df2) <- c("household_income_quartile", "Free")
  
  
  combined_df2 <- left_join(user_df2, free_df2) %>% 
    mutate(Paid = General - Free) %>% 
    pivot_longer(-household_income_quartile, names_to = "type", values_to = "avg") 
  
  
  plot_df2 <- combined_df2 %>% 
    filter(type != "General") %>% 
    filter(household_income_quartile != "Total, household income quartiles") %>% 
    mutate(household_income_quartile=case_when(household_income_quartile == "Highest quartile household income" ~ "Highest quartile",
                                               household_income_quartile == "Lowest quartile household income" ~ "Lowest quartile",
                                               household_income_quartile == "Second quartile household income" ~ "Second quartile",
                                               household_income_quartile == "Third quartile household income" ~ "Third quartile")) 
  
  
  plot2012 <- ggplot(plot_df2, aes(x=type, y=avg, fill=type)) + 
    geom_bar(stat='identity') +
    facet_wrap(~household_income_quartile, ncol=5, scales = 'free') +
    labs(title = "Average Usage of each security software usage by income group in 2012", 
         y = "Average Usage", 
         x = "Security Software Version") +
    theme(
      plot.title = element_text(face = "bold", size = 12),
      axis.title = element_text(face = "bold", size = 12),
      legend.position = "none",
      strip.text.x = element_text(face = "bold", size = 10)
    ) 
  
  # save the 2012 plot to png files
  ggsave(paste0(out_path, "/2012plot.png"), 
         plot2012,
         width = 8, 
         height = 10)
  
  
}


main(opt$input, opt$out_path)

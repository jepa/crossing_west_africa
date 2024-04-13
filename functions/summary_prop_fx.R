
# Function modified from Palacios-Abrantes et acl (2020) code.
# Estimates the SSR per species by combining the routine including SummaryProp and PropChange
summary_trans_ssr <- function(taxon_key,nwa_countries){
  
  print(taxon_key)
  # SummaryProp
  
  # Reads taxon data
  proportion_data <- fread(paste(my_path("G",extra_path = "EmergingFish/Results/Proportion_2005c/"),"proportion_",taxon_key,".csv", sep="")) %>% 
    filter(!is.na(eez_neighbour)) %>% 
    select(
      1:4,
      ensemble_mean = catch_proportion_temp_mean_ensemble_mean,
      ensemble_sd = catch_proportion_temp_mean_ensemble_sd) %>% 
    filter(!is.na(ensemble_mean),
           !is.na(ensemble_sd),
           eez_name %in% nwa_countries,
           eez_neighbour %in% nwa_countries) 
  
  # Remove cases where not all ensemble members had data
  To_be_removed <- proportion_data %>% 
    group_by(taxon_key,eez_name,eez_neighbour) %>%
    tally() %>% 
    filter(n != 3)
  
  proportion_data_filter <- proportion_data %>% 
    left_join(To_be_removed) %>% 
    filter(is.na(n)) %>% 
    select(-n) %>% 
    left_join(To_be_removed %>% select(eez_neighbour = eez_name, eez_name = eez_neighbour,n)) %>% 
    filter(is.na(n)) %>% 
    select(-n)
  
  # Identify SSR treshold for natural spatial variability of the stock
  proportion_tresh <- proportion_data_filter %>% 
    filter(time_step == "historical") %>% 
    mutate(
      top_tresh = ensemble_mean+(2*ensemble_sd), # two s.d.
      low_tresh = ensemble_mean-(2*ensemble_sd) # two.s.d
    ) %>% 
    select(taxon_key:eez_neighbour,top_tresh:low_tresh) %>% 
    left_join(proportion_data) %>% 
    # Only keeps change if surpasses treshold
    mutate(
      over_tresh = ifelse(time_step != "historical" & ensemble_mean > top_tresh | time_step != "historical" & ensemble_mean < low_tresh,"keep",
                          ifelse(time_step == "historical","keep",
                                 "drop")
      ),
      time_step = ifelse(time_step == "early","time_early",
                         ifelse(time_step == "mid","time_mid","time_historical")
      )
    ) %>% 
    filter(over_tresh == "keep") %>%
    select(-top_tresh,-low_tresh,-over_tresh)
  
  
# Get the stock proportion in the three time steps
  country_summary <- proportion_tresh %>%
    select(-ensemble_sd) %>%
    spread(time_step,ensemble_mean) %>%
    mutate_at(vars(matches("time_")), ~round(.*100,2))
  
  return(country_summary)
}

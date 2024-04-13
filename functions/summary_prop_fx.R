
# Function modified from Palacios-Abrantes et acl (2020) code.
# Estimates the SSR per species by combining the routine including SummaryProp and PropChange

taxon_key = 600228

summary_ssr <- function(taxon_key){
  
  print(taxon_key)
  # SummaryProp
  
    # Reads taxon data
    proportion_data <- fread(paste(my_path("G",extra_path = "EmergingFish/Results/Proportion_2005c/"),"proportion_",taxon_key,".csv", sep="")) %>% 
      filter(!is.na(eez_neighbour)) %>% 
      select(
        1:4,
        ensemble_mean = catch_proportion_temp_mean_ensemble_mean,
        ensemble_sd = catch_proportion_temp_mean_ensemble_sd)
    
  
  # Identify SSR treshold for natural spatial variability of the stock
  proportion_tresh <- proportion_data %>% 
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
      ifelse(time_step == "mid","time_mid","historical")
      )
    ) %>% 
    # filter(time_step !="historical" | over_tresh == "keep") %>%
    filter(over_tresh == "keep") %>%
    select(-top_tresh,-low_tresh)
  
    # summarizes by country
  country_summary <- proportion_tresh %>% 
    group_by(taxon_key,eez_name,eez_neighbour,time_step) %>% 
    summarise(
      mean_spp = mean(ensemble_mean,na.rm=T) # average spp change from all countries sharing that speceies
    ) %>% 
    filter(!is.na(mean_spp)) %>% 
    spread(time_step,mean_spp) %>% 
    mutate_at(vars(matches("time")), ~round((.-historical)/(abs(historical))*100,2))
  
    
  return(country_summary)
}

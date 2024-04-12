
# Function modified from Palacios-Abrantes et acl (2020) code.
# Estimates the SSR per species
taxon_key <- 600006

SummaryProp <- function(taxon_key,links="NA"){
  
  
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
      over_tresh = ifelse(time_step != "historical" & ensemble_mean > top_tresh | ensemble_mean < low_tresh,"keep",
                          ifelse(time_step == "historical","keep","drop")
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
      filter(!is.na(mean_spp))
  
  return(country_summary)
}

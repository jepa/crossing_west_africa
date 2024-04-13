

# FUNCTION TO READ DATA 
# This  function simply reads straddling stock share ratio proportion data and filters the realms we want


# FOR TESTING
# spp_path <- "~/Library/CloudStorage/OneDrive-UBC/Data/MigrantFish/Results/Per_change_realm_rfmo/600006_perchg.csv"


read_ssr_stradd <- function(spp_path,realm){
  
  # print(spp_path)  
  suppressMessages(
    df_return <- read_csv(spp_path) %>% 
      filter(realm_name %in% realm) %>% 
      group_by(taxon_key,rcp,period,rfmo_name,realm_name,change) %>% 
      summarise_if(is.numeric,mean,na.rm = T)
  ) 
  return(df_return)
}

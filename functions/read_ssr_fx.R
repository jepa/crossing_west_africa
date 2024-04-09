

# FUNCTION TO READ DATA 
  # This  function simply reads transboundary stock shsare ratio proportion data and filters the eezs we want


# FOR TESTING
# spp_path <- ssr_to_read[1]
# ssp_path <- "~/Library/CloudStorage/OneDrive-UBC/Data/EmergingFish/Results/Proportion_2005c/proportion_690378.csv"



read_proportion <- function(spp_path,eez){

  # print(spp_path)  
  suppressMessages(
    df_return <- read_csv(spp_path) %>% 
      filter(eez_name %in% eez)
  )
  return(df_return)
  
  }

# Due to a decoding issue I convert the file to a new one that can be handled by pandas
# R Code, do not run in Python
# Load packages
library(tidyverse); library(haven)
# Import data
path <- '../Data/CCES/CCES_Panel_Full3waves_VV_V4.dta'
df_cses <- read_dta(path)

# Deal with erroneously decoded NAs ("__NA__" or "")
df_cses1 <- df_cses %>% 
  mutate(
    across(where(is.character), \(x) ifelse(x %in% c("__NA__", ""), NA_character_, x))
  )

df_cses <- df_cses %>% 
  mutate(
    across(where(is.character), \(x) str_replace(x, "__NA__", NA_character_)),
    across(where(is.character), \(x) na_if(x, ""))
  )

# Write new stata file (csv would not retain the column types)
new_path <- path <- '../Data/CCES/CCES_Panel_Full3waves_VV_V4_LRS.dta'
write_dta(df_cses, new_path)

##################################################################
# Goal : transpose weather df from wide  to long
# input: market_df in wide 
# output: market_df_transpose, a data frame in the long format with clust/lhz in the first column
#################################
library(tidyverse)
library(stringr)

MktReshape <- function(market_df){
  
  tryCatch(
    {  market_df = market_df %>%  dplyr::select(-X)},
    error = function(e){
      market_df = market_df
    }
      )

  
#  position = str_which(colnames(market_df), "X2006.01.01") 

  if (colnames(market_df)[1]=="FNID"){
    position = which(colnames(market_df)=="weights") + 1 
    
  } else {
    position = which(colnames(market_df)=="dist_km") + 1 
    
  }

  
  
  market_df_long = market_df  %>%
    tidyr:: gather( key = date, value ="value", position:ncol(market_df))  # wide to long 
  
  date = market_df_long["date"]
  date_mkt = gsub(x=as.matrix(date),"X","")
  
  date_mkt= lubridate::ymd(date_mkt)
  market_df_long["date"] = date_mkt
  
  
  # date_mkt = as.Date(date_mkt,format = "%Y.%m.%d" )
  # market_df_long["yearmon"] = as.yearmon(date_mkt)
    
    
    
  return(market_df_long) 
}

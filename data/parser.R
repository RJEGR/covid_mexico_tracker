# =========================================================================
# Data parser script
# =========================================================================

preprocessing_data <- function() {
  # Covid-19 daily reports from github
  URL <- 'https://raw.githubusercontent.com/carranco-sga/Mexico-COVID-19/master/Mexico_COVID19.csv'
  raw_daily_data <- read.csv(URL, stringsAsFactors =  FALSE)
  
  # Mexico map preprocessed
  data_list <- readRDS('data/data.rds')
  
  # ******** National Reports ********
  # Preprocessing main values: Positive, Recovered, Local, Imported and Deaths
  column_cases <- c('Fecha', 'Pos_rep', 'Susp_rep', 'Neg_rep', 'Recovered', 'Deceased', 'Tested_tot')
  df_total_reps <- raw_daily_data[, column_cases]
  
  # ******** Daily Reports per State ********
  ord_state_names <- data_list$ord_state_names
  df_pos_states <- raw_daily_data[, -grep("\\_.*$", colnames(raw_daily_data))]
  # Remove unusefull columns
  df_pos_states[, c('Fecha', 'Pos', 'Recovered', 'Deceased', 'Susp')] <- NULL
  # Order the state names to match the map ordering
  colnames(df_pos_states) <- ord_state_names
  df_pos_states <- df_pos_states[ , order(names(df_pos_states))]
  
  # ******** Current Dates ********
  # Get the number of maximum cases of any category for TODAY
  max_today <- apply(df_pos_states, 2, max, na.rm = TRUE)
  # First date
  first_date <- head(raw_daily_data$Fecha, n = 1)[1]
  # Last date
  last_date <- tail(raw_daily_data$Fecha, n = 1)[1]
  
  # ******** Map Data ********
  mexico <- data_list$mexico
  
  # ******** Return a list of data *******
  parser <- list(
    df_total_reps = df_total_reps,
    df_pos_states = df_pos_states,
    max_today = max_today,
    first_date = first_date,
    last_date = last_date,
    mexico = mexico
  )
  
  return(parser)
}
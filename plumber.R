library(plumber)
library(baseballr)
library(dplyr)

#* @apiTitle Statcast Pitch Breakdown API

#* Get a batter's Statcast stats vs pitch types
#* @param player_name Full player name (e.g., Aaron Judge)
#* @param year Year (e.g., 2024)
#* @get /player_pitch_stats
function(player_name, year = 2024) {
  data <- statcast_search_batter(
    batter_name = player_name,
    start_date = paste0(year, "-03-01"),
    end_date = paste0(year, "-10-01")
  )

  output <- data %>%
    group_by(pitch_type) %>%
    summarise(
      pitches = n(),
      avg_exit_velocity = mean(launch_speed, na.rm = TRUE),
      hr_rate = mean(events == "home_run", na.rm = TRUE)
    )

  return(output)
}

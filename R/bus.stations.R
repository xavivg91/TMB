

bus.stations <- function(app_id, app_key, line){

  # If you don't specify the line, the function retrieves data from all bus stations
  if(missing(line)){

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/parades?app_id="
    url2 <- "&app_key="
    url3 <- paste0(url1, app_id, url2, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url3, flatten=TRUE)$features

  # The function retrieves data from bus stations corresponding to the specified line
  }else{

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/"
    url2 <- "/parades?app_id="
    url3 <- "&app_key="
    url4 <- paste0(url1, line, url2, app_id, url3, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url4, flatten=TRUE)$features

  }

  latitude <- vector()
  longitude <- vector()

  # Latitude and longitude in separate columns
  for(i in 1:nrow(dataset)){

    latitude[i] <- dataset$geometry.coordinates[[i]][1]
    longitude[i] <- dataset$geometry.coordinates[[i]][2]

  }

  dataset <- cbind(dataset, latitude, longitude) %>%
    dplyr::select()

}


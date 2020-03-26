bus.stations <- function(app_id, app_key, line){

  # If you don't specify the line, the function retrieves data from all bus stations
  if(missing(line)){

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/parades?app_id="
    url2 <- "&app_key="
    url3 <- paste0(url1, app_id, url2, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url3, flatten=TRUE)
    dataset$features

  # The function retrieves data from bus stations corresponding to the specified line
  } else{

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/"
    url2 <- line
    url3 <- "/parades?app_id="
    url4 <- "&app_key="
    url5 <- paste0(url1, url2, url3, app_id, url4, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url5, flatten=TRUE)
    dataset$features

  }

}


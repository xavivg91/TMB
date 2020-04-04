#' Get data from the metro service in Barcelona
#' @description The \code{metro.stations()} function opens a connection
#' to the \href{https://www.tmb.cat/en/home}{TMB} API to retrieve data related
#' to the metro stations and lines in Barcelona.
#'
#'
#' @param app_id character
#' @param app_key character
#' @param line numeric
#' @author Xavier Vivancos
#' @usage
#' # Without the line argument, the function retrieves
#' # data from all metro stations
#' metro.stations(app_id, app_key)
#'
#' # Metro stations corresponding to the specified line
#' metro.stations(app_id, app_key,
#'                line = c(1, 2, 3, 4, 5, 11, 91,
#'                         94, 99, 101, 104))
#' @details
#'  \itemize{
#'   \item{To execute the function you need the credentials \code{app_id} and
#'   \code{app_key}.
#'    Register on the \href{https://developer.tmb.cat/docs/getting-started}{TMB API portal}
#'    and create an application to obtain your credentials}
#'  \item{If you want to retrieve all the metro stations
#'  and their resources, execute the function without arguments.}
#'  \item{You can filter by metro line and obtain a subset.}
#'  }
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr select rename mutate_at filter
#' @importFrom jsonlite fromJSON
#' @export metro.stations
metro.stations <- function(app_id, app_key, line){

  # If you don't specify the line, the function retrieves data from all metro stations
  if(missing(line)){

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/metro/estacions?app_id="
    url2 <- "&app_key="
    url3 <- paste0(url1, app_id, url2, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url3, flatten=TRUE)$features

    # The function retrieves data from metro stations corresponding to the specified line
  }else{

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/metro/"
    url2 <- "/estacions?app_id="
    url3 <- "&app_key="
    url4 <- paste0(url1, line, url2, app_id, url3, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url4, flatten=TRUE)$features

  }

  Latitude <- vector()
  Longitude <- vector()

  # Latitude and longitude in separate columns
  for(i in 1:nrow(dataset)){

    Latitude[i] <- dataset$geometry.coordinates[[i]][1]
    Longitude[i] <- dataset$geometry.coordinates[[i]][2]

  }

  # Select fields
  cbind(dataset, Latitude, Longitude) %>%
    dplyr::select(properties.CODI_ESTACIO, properties.NOM_ESTACIO,
                  properties.ORDRE_ESTACIO, properties.CODI_LINIA,
                  properties.NOM_LINIA, properties.ORIGEN_SERVEI,
                  properties.DESTI_SERVEI, properties.DATA_INAUGURACIO, Latitude,
                  Longitude) %>%
    dplyr::arrange(properties.CODI_LINIA,  properties.ORDRE_ESTACIO) %>%
    dplyr::rename(`Station code`=properties.CODI_ESTACIO,
                  `Station name`=properties.NOM_ESTACIO,
                  `Order`=properties.ORDRE_ESTACIO,
                  `Line code`=properties.CODI_LINIA,
                  `Line name`=properties.NOM_LINIA,
                  `Line origin`=properties.ORIGEN_SERVEI,
                  `Line destination`=properties.DESTI_SERVEI,
                  `Opening date`=properties.DATA_INAUGURACIO)%>%
    dplyr::mutate_at(c(4, 5, 6, 7), as.factor)
}

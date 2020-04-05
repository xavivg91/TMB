#' Get data from the bus service in Barcelona
#' @description The \code{bus.stops()} function opens a connection
#' to the \href{https://developer.tmb.cat/}{TMB API} to retrieve data related
#' to the bus stops and lines in Barcelona. You can extract information like
#' routes, geographical data (including latitude and longitude),
#' distance between bus stops, etc.
#'
#' @param app_id character
#' @param app_key character
#' @param line numeric
#' @author Xavier Vivancos
#' @usage
#' # Without the line argument, the function retrieves
#' # data from all bus stops
#' bus.stops(app_id, app_key)
#'
#' # Bus stops corresponding to the specified line
#' bus.stops(app_id, app_key,
#'           line = c(6, 7, 11, 13, 19, 21, 22, 23, 24, 27, 33, 34, 39,
#'                    46, 47, 52, 54, 55, 59, 60, 62, 63, 65, 67, 68,
#'                    70, 75, 76, 78, 79, 91, 94, 95, 96, 97, 100, 101,
#'                    102, 103, 104, 107, 109, 110, 111, 112, 113, 114,
#'                    115, 116, 117, 118, 119, 120, 121, 122, 123, 124,
#'                    125, 126, 127, 128, 129, 130, 131, 132, 133, 135,
#'                    136, 150, 155, 157, 165, 185, 191, 192, 196, 201,
#'                    202, 203, 204, 205, 206, 207, 208, 209, 210, 211,
#'                    212, 213, 214, 215, 216, 217, 219, 220, 221, 223,
#'                    225, 227, 229, 231, 233, 240, 250))
#' @details
#'  \itemize{
#'   \item{To execute the function you need the credentials \code{app_id} and
#'   \code{app_key}.
#'    Register on the \href{https://developer.tmb.cat/docs/getting-started}{TMB API portal}
#'    and create an application to obtain your credentials}
#'  \item{If you want to retrieve all the bus stops
#'  and their resources, execute the function without arguments.}
#'  \item{You can filter by bus line and obtain a subset.}
#'  }
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom dplyr select rename mutate_at filter
#' @importFrom jsonlite fromJSON
#' @export bus.stops
bus.stops <- function(app_id, app_key, line){

  # If you don't specify the line, the function retrieves data from all bus stops
  if(missing(line)){

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/parades?app_id="
    url2 <- "&app_key="
    url3 <- paste0(url1, app_id, url2, app_key)

    # Data set
    dataset <- jsonlite::fromJSON(url3, flatten=TRUE)$features

  # The function retrieves data from bus stops corresponding to the specified line
  }else{

    # URL containing the requested data set
    url1 <- "https://api.tmb.cat/v1/transit/linies/bus/"
    url2 <- "/parades?app_id="
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
    dplyr::select(properties.ID_RECORREGUT, properties.CODI_PARADA,
                  properties.NOM_PARADA, properties.ADRECA, properties.NOM_VIA,
                  properties.NOM_DISTRICTE, properties.NOM_POBLACIO,
                  properties.ORDRE, properties.DISTANCIA_PAR_ANTERIOR,
                  properties.ES_ORIGEN, properties.ES_DESTI, properties.ORIGEN_SENTIT,
                  properties.DESTI_SENTIT, properties.ID_SENTIT, properties.DESC_SENTIT,
                  properties.ID_LINIA, properties.CODI_LINIA, properties.NOM_LINIA, Latitude,
                  Longitude) %>%
    dplyr::arrange(properties.CODI_LINIA, properties.ID_SENTIT, properties.ORDRE) %>%
    dplyr::rename(`Route ID`=properties.ID_RECORREGUT,
                  `Bus stop code`=properties.CODI_PARADA,
                  `Bus stop name`=properties.NOM_PARADA,
                  `Adress`=properties.ADRECA,
                  `District`=properties.NOM_DISTRICTE,
                  `Municipality`=properties.NOM_POBLACIO,
                  `Street`=properties.NOM_VIA,
                  `Bus stop order`=properties.ORDRE,
                  `Distance to previous bus stop`=properties.DISTANCIA_PAR_ANTERIOR,
                  `isOrigin`=properties.ES_ORIGEN, `isDestination`=properties.ES_DESTI,
                  `Line origin`=properties.ORIGEN_SENTIT,
                  `Line destination`=properties.DESTI_SENTIT,
                  `Direction ID`=properties.ID_SENTIT,
                  `Direction`=properties.DESC_SENTIT,
                  `Line ID`=properties.ID_LINIA,
                  `Line code`=properties.CODI_LINIA,
                  `Line name`=properties.NOM_LINIA) %>%
    dplyr::mutate_at(c(5, 6, 7, 12, 13, 15), as.factor)


}



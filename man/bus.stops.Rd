% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bus.stops.R
\name{bus.stops}
\alias{bus.stops}
\title{Get data from the bus service in Barcelona}
\usage{
# Without the line argument, the function retrieves
# data from all bus stops
bus.stops(app_id, app_key)

# Bus stops corresponding to the specified line
bus.stops(app_id, app_key,
          line = c(6, 7, 11, 13, 19, 21, 22, 23, 24, 27, 33, 34, 39,
                   46, 47, 52, 54, 55, 59, 60, 62, 63, 65, 67, 68,
                   70, 75, 76, 78, 79, 91, 94, 95, 96, 97, 100, 101,
                   102, 103, 104, 107, 109, 110, 111, 112, 113, 114,
                   115, 116, 117, 118, 119, 120, 121, 122, 123, 124,
                   125, 126, 127, 128, 129, 130, 131, 132, 133, 135,
                   136, 150, 155, 157, 165, 185, 191, 192, 196, 201,
                   202, 203, 204, 205, 206, 207, 208, 209, 210, 211,
                   212, 213, 214, 215, 216, 217, 219, 220, 221, 223,
                   225, 227, 229, 231, 233, 240, 250))
}
\arguments{
\item{app_id}{character}

\item{app_key}{character}

\item{line}{numeric}
}
\description{
The \code{bus.stops()} function opens a connection
to the \href{https://developer.tmb.cat/}{TMB API} to retrieve data related
to the bus stops and lines in Barcelona. You can extract information like
routes, geographical data (including latitude and longitude),
distance between bus stops, etc.
}
\details{
\itemize{
  \item{To execute the function you need the credentials \code{app_id} and
  \code{app_key}.
   Register on the \href{https://developer.tmb.cat/docs/getting-started}{TMB API portal}
   and create an application to obtain your credentials}
 \item{If you want to retrieve all the bus stops
 and their resources, execute the function without arguments.}
 \item{You can filter by bus line and obtain a subset.}
 }
}
\author{
Xavier Vivancos
}

#' Download WID data
#'
#' @param indicators Indiciator to download, defaults to "sptinc". See  for additional indicators and more.
#'
#' @return A tibble containing the income data.
#' @export
#' @import wid
#'
get_wid_data <- function(indicators = "sptinc"){
  wid::download_wid(indicators) %>%
    dplyr::as_tibble()
}

#' Plot Lorenz Curve for a specified country
#'
#' @param wid_data A tibble imported via.
#' @param country  A string giving the country.
#'
#' @return A plot of the Lorenz Curve
#' @export
#'
#' @import tidyverse
#' @import drake
plot_lorenz <- function(ctry = "GB"){
  drake::readd(data) %>%
    dplyr::filter(country == ctry) %>%
    dplyr::filter(percentile %in% paste0("p", 0:99, "p", 1:100)) %>%
    dplyr::mutate(perc = stringr::str_extract(percentile, "\\d+$") %>% as.numeric()) %>%
    dplyr::group_by(variable, year) %>%
    dplyr::arrange(perc) %>%
    dplyr::mutate(inc = cumsum(value) * 100) %>%
    ggplot2::ggplot(mapping = ggplot2::aes(x = perc, y = inc, color = year)) +
    ggplot2::geom_point() +
    ggplot2::scale_color_viridis_c() +
    ggplot2::labs(title = ctry) +
    ggplot2::geom_abline(intercept = 0, slope=1, color = "red") +
    ggplot2::facet_wrap(~variable)
}

#' List all country ID's
#'
#' @return The unique ID's of the countries in the WID-Sample.
#' @export
#'
country_list <- function(){
  readd(data)$country %>%
    unique()
}

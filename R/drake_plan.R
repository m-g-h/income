
#' Drake plan for the package.
#'
#' @return A drake plan used in.
#'
#' @export
#'
income_plan <- function(){
  drake::drake_plan(
    data = income::get_wid_data()
  )
}


#' "Make" the project with.
#'
#' @param jobs Number of jobs for parallel processing with.
#'
#' @export
#'
make_project <- function(jobs = 1){
  drake::make(income::income_plan())
}

#' Show the workflow diagram of the drake-plan.
#'
#' @export
#'
show_project <- function(){
  drake::vis_drake_graph(drake::drake_config(income::income_plan()))
}

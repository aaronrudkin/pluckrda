#' List objects inside a .rda file
#'
#' Lists all objects from a .rda \code{file}.
#'
#' @param file a (readable binary-mode) connection or a character string giving
#' the name of the file to load (when tilde expansion is done).
#' @param verbose a logical value, defaulting to TRUE, which specifies whether
#' to print the results.
#'
#' @return a vector of character strings naming the objects inside \code{file}.
#'
#' @export
list_objects = function(file, verbose=TRUE) {
  if(!file.exists(file)) {
    stop(
      "Error in `load_rda` call. The file '",
      file, "' does not exist."
    )
  }

  tmp_env = new.env(parent = emptyenv())
  load(file, envir = tmp_env, verbose = verbose)
  object_names = ls(tmp_env)

  if(verbose) {
    cat(paste0(
      "The objects in `", file, "` are:\n  ",
      paste0(object_names, collapse = "\n  "),
      "\n"
    ))
  }
  return(object_names)
}

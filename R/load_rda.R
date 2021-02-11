#' Load objects from inside a .rda file
#'
#' Load a subset of objects from a .rda \code{file} into an environment.
#' If no objects are specified, this function is simply a transparent call
#' to \link{load}. If objects are specified, only those objects will be loaded
#' from the .rda file.
#'
#' @section Side Effects:
#' The loaded objects are present in the frame specified in \code{envir}, by
#' default the calling environment.
#'
#' @param file a (readable binary-mode) connection or a character string giving
#' the name of the file to load (when tilde expansion is done).
#' @param envir the environment where the data should be loaded, by default the
#' calling environment of the function
#' @param verbose should item names be printed during loading? This argument is
#' used only in the call make to \link{load} function, and so all
#' object names will be printed even if \code{objects} is specified
#' @param objects A vector of character strings naming the objects to load. If
#' the vector is un-named the objects will be loaded with the names they are
#' stored under in the .rda file. If the vector is named, the objects will be
#' renamed as they are loaded.
#'
#' @return NULL
#'
#' @export
load_rda = function(file, envir = parent.frame(), verbose = FALSE,
                    objects = NULL) {
  if(!file.exists(file)) {
    stop(
      "Error in `load_rda` call. The file '",
      file, "' does not exist."
    )
  }
  if(length(objects) == 0) {
    return(load(file, envir = envir, verbose = verbose))
  }

  tmp_env = new.env(parent = emptyenv())
  load(file, envir = tmp_env, verbose = verbose)

  if(!all(objects %in% ls(tmp_env))) {
    missing_objects = objects[which(!objects %in% ls(tmp_env))]
    stop(paste0(
      "Error in `load_rda` call. The following objects are not present in ",
      "the file '", file, "': ",
      paste0(sort(missing_objects), collapse = ", "),
      ".\n\nThe complete list of objects in this file is: ",
      paste0(sort(ls(tmp_env)), collapse = ", ")
    ))
  }

  check_names = names(objects)[names(objects) != ""]
  if(length(check_names)) {
    if(!identical(make.names(check_names), check_names)) {
      bad_names = check_names[which(check_names != make.names(check_names))]
      stop(paste0(
        "Error in `load_rda` call. The following variable names you ",
        "specified are not valid R object names: ",
        paste0(bad_names, collapse = ", ")
      ))
    }
  }

  for(i in seq.int(length(objects))) {
    if(is.null(names(objects)) || names(objects)[i] == "") {
      envir[[objects[i]]] = tmp_env[[objects[i]]]
    } else {
      envir[[names(objects)[i]]] = tmp_env[[objects[i]]]
    }
  }

  invisible(NULL)
}

test_that("File not found", {
  expect_error(load_rda("invalid_file_error.ext"))
})

test_that("File isn't an RDA file", {
  pluckrda_test_nonrda = system.file(
    "extdata", "pluckrda_test_nonrda.txt", package="pluckrda")
  expect_error(
    suppressWarnings({load_rda(pluckrda_test_nonrda)})
  )
})

test_that("Asked for an invalid object", {
  pluckrda_test = system.file(
    "extdata", "pluckrda_test_rda.rda", package = "pluckrda")
  expect_error(load_rda(pluckrda_test, objects = "invalid_object"))
})

test_that("Transparent passthrough of load", {
  load_rda(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda")
  )
  expect_equal(ls(), c("pluckrda_test_func", "pluckrda_test_obj"))
  expect_equal(pluckrda_test_func(), TRUE)
  on.exit(rm(list=ls()), add=TRUE, after=FALSE)
})

test_that("Loaded a single object", {
  load_rda(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    objects = "pluckrda_test_obj")
  expect_equal(pluckrda_test_obj, 1L)
  expect_equal(ls(), "pluckrda_test_obj")
  on.exit(rm(list=ls()), add=TRUE, after=FALSE)
})

test_that("Loaded a named object", {
  load_rda(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    objects = c("rename_inline" = "pluckrda_test_obj"))
  expect_equal(rename_inline, 1L)
  expect_equal(ls(), "rename_inline")
  on.exit(rm(list=ls()), add=TRUE, after=FALSE)
})

test_that("Loaded to a non-calling environment", {
  pluckrda_test_env = new.env()
  load_rda(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    pluckrda_test_env)
  expect_equal(ls(), "pluckrda_test_env")
  expect_equal(
    ls(pluckrda_test_env),
    c("pluckrda_test_func", "pluckrda_test_obj"))
  on.exit(rm(list=ls()), add=TRUE, after=FALSE)
})

test_that("Invalid variable name specified", {
  expect_error(suppressWarnings({ load_rda(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    objects = c("00invalid_variable_name" = "pluckrda_test_obj")) }))
  on.exit(rm(list=ls()), add=TRUE, after=FALSE)
})

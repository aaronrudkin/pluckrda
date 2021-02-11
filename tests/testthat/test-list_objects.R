test_that("File not found", {
  expect_error(list_objects("invalid_file_error.ext"))
})

test_that("File isn't an RDA file", {
  pluckrda_test_nonrda = system.file(
    "extdata", "pluckrda_test_nonrda.txt", package="pluckrda")
  expect_error(
    suppressWarnings({list_objects(pluckrda_test_nonrda)})
  )
})

test_that("Returns are correct", {
  expect_output(list_objects(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    verbose=TRUE
  ))

  expect_silent(list_objects(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    verbose=FALSE
  ))

  result = list_objects(
    system.file("extdata", "pluckrda_test_rda.rda", package = "pluckrda"),
    verbose=FALSE
  )

  expect_equal(result, c("pluckrda_test_func", "pluckrda_test_obj"))
})

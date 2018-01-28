context("to_parsed_case_internal")

test_that("condition 6", {
  expect_error(to_parsed_case_internal("bla", parsing_option = 7),
               "parsing_option must be 1,2,3,4 or <= 0 for no parsing.")}
)

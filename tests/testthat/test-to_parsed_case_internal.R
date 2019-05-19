context("to_parsed_case_internal")

test_that("condition 6", {
  expect_error(to_parsed_case_internal("bla", parsing_option = 7),
               "parsing_option must be between -4 and +4.", fixed = TRUE)}
)

test_that("parsing_option 3", {
  expect_equal(to_parsed_case_internal("look_AfterThe-hyphen andThe.dot", parsing_option = -1, numerals = "asis"),
               "look_After_The-hyphen_and_The.dot")}
)

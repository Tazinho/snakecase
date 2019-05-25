context("to_parsed_case_internal")

test_that("condition 6", {
  expect_error(to_parsed_case_internal("bla", parsing_option = 7),
               "parsing_option must be between -4 and +4.", fixed = TRUE)}
)

test_that("parsing_option -1", {
  expect_equal(to_parsed_case_internal("look_AfterThe-hyphen andThe.dot", parsing_option = -1, numerals = "asis", abbreviations = NULL, sep_in = NULL),
               "look_After_The-hyphen and_The.dot")}
)

test_that("all", {
  expect_equal(to_parsed_case_internal(string  = "bla", numerals = "asis", parsing_option = 2, sep = "_", abbreviations = NULL),
               "bla")
  }
)

test_that("split", {
  expect_equal(to_parsed_case_internal("bla_ lbla", abbreviations = NULL, sep_in =NULL, numerals = "middle")
               ,
               "bla_ _lbla")
  }
)
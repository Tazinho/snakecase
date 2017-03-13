context("to_small_camel_case")

test_that("basic usage", {
  
  camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case",
                  "_camel_case__")
  small_camel_cases <- c("smallCamelCase", "bigCamelCase", "mixedCase", "snakeCase",
                   "camelCase")
  expect_equal(to_small_camel_case(camelCases), small_camel_cases)
  
})
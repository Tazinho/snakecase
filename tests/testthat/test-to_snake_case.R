context("to_snake_case")

test_that("basic usage", {
  
  camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case",
                  "_camel_case__")
  snake_cases <- c("small_camel_case", "big_camel_case", "mixed_case", "snake_case",
                  "camel_case")
  expect_equal(to_snake_case(camelCases), snake_cases)

})
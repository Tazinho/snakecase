context("to_big_camel_case")

test_that("basic usage", {
  
  camelCases <- c("smallCamelCase", "BigCamelCase", "mixed_Case", "snake_case",
                  "_camel_case__")
  big_camel_cases <- c("SmallCamelCase", "BigCamelCase", "MixedCase", "SnakeCase",
                   "CamelCase")
  expect_equal(to_big_camel_case(camelCases), big_camel_cases)
  
})
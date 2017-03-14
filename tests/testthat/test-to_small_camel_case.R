context("to_small_camel_case")

test_that("basic usage", {
  
  examples <- c(NA,
                "snake_case",
                "snakeCase",
                "SnakeCase",
                "snake_Case")
  
  small_camel_case <- c(NA, 
                        "snakeCase",
                        "snakeCase",
                        "snakeCase",
                        "snakeCase")
  
  expect_equal(to_small_camel_case(examples),
               small_camel_case)
  
})
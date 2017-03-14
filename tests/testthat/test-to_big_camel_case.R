context("to_big_camel_case")

test_that("basic usage", {
  
  examples <- c(NA,
                "snake_case",
                "snakeCase",
                "SnakeCase",
                "snake_Case")
  
  big_camel_case <- c(NA, 
                      "SnakeCase", 
                      "SnakeCase",
                      "SnakeCase",
                      "SnakeCase")
  
  expect_equal(to_big_camel_case(examples),
               big_camel_case)
  
})
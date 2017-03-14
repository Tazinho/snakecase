context("to_snake_case")

test_that("basic usage", {
  
  examples <- c(NA,
                "snake_case",
                "snakeCase",
                "SnakeCase",
                "snake_Case")
  
  snake_case <- c(NA,
                  "snake_case",
                  "snake_case",
                  "snake_case",
                  "snake_case")
  
  expect_equal(to_snake_case(examples),
               snake_case)

})
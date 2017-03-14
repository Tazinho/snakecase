context("to_snake_case")

test_that("basic usage", {
  
  examples <- c(NA,
                "snake_case",
                "snakeCase",
                "SnakeCase",
                "_",
                "snake_Case",
                "_",
                "8",
                "Snake"
                )
  
  snake_case <- c(NA,
                  "snake_case",
                  "snake_case",
                  "snake_case",
                  "",
                  "snake_case",
                  "",
                  "8",
                  "snake")
  
  expect_equal(to_snake_case(examples),
               snake_case)

})
context("to_small_camel_case")

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
  
  small_camel_case <- c(NA, 
                        "snakeCase",
                        "snakeCase",
                        "snakeCase",
                        "",
                        "snakeCase",
                        "",
                        "8",
                        "snake")
  
  expect_equal(to_small_camel_case(examples),
               small_camel_case)
  
})
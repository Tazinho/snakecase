context("to_big_camel_case")

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
  
  big_camel_case <- c(NA, 
                      "SnakeCase", 
                      "SnakeCase",
                      "SnakeCase",
                      "",
                      "SnakeCase",
                      "",
                      "8",
                      "Snake")
  
  expect_equal(to_big_camel_case(examples),
               big_camel_case)
  
})
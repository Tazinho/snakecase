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
                "Snake",
                "s_nake",
                "sn_ake",
                "_",
                "13",
                "14",
                "s_na_k_er",
                "_",
                "SNAKE SNAKE CASE",
                "_"
  )
  
  big_camel_case <- c(NA, 
                      "SnakeCase", 
                      "SnakeCase",
                      "SnakeCase",
                      "",
                      "SnakeCase",
                      "",
                      "8",
                      "Snake",
                      "SNake",
                      "SnAke",
                      "",
                      "13",
                      "14",
                      "SNaKEr",
                      "",
                      "SnakeSnakeCase",
                      "")
  
  expect_equal(to_big_camel_case(examples),
               big_camel_case)
  
})
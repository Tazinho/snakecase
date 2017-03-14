context("to_big_camel_case")

test_that("basic usage", {
  
  examples <- c(NA,
                "snake_case",
                "snakeCase",
                "SnakeCase",
                "_",
                "snake_Case",
                "_",
                "SNake",
                "Snake",
                "s_nake",
                "sn_ake",
                "_",
                "SNaKE",
                "SNaKEr",
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
                      "SNake",
                      "Snake",
                      "SNake",
                      "SnAke",
                      "",
                      "SNaKe",
                      "SNaKEr",
                      "SNaKEr",
                      "",
                      "SnakeSnakeCase",
                      "")
  
  expect_equal(to_big_camel_case(examples),
               big_camel_case)
  
})
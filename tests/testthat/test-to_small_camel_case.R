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
  
  small_camel_case <- c(NA, 
                        "snakeCase",
                        "snakeCase",
                        "snakeCase",
                        "",
                        "snakeCase",
                        "",
                        "8",
                        "snake",
                        "sNake",
                        "snAke",
                        "",
                        "13",
                        "14",
                        "sNaKEr",
                        "",
                        "snakeSnakeCase",
                        "")
  
  expect_equal(to_small_camel_case(examples),
               small_camel_case)
  
})
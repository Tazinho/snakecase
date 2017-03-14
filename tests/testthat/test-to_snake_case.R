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
  
  snake_case <- c(NA,
                  "snake_case",
                  "snake_case",
                  "snake_case",
                  "",
                  "snake_case",
                  "",
                  "8",
                  "snake",
                  "s_nake",
                  "sn_ake",
                  "",
                  "13",
                  "14",
                  "s_na_k_er",
                  "",
                  "snake_snake_case",
                  ""
                  )
  
  expect_equal(to_snake_case(examples),
               snake_case)

})
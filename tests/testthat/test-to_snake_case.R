# context("to_snake_case")
# 
# test_that("basic usage", {
#   
#   examples <- c(NA,
#                 "snake_case",
#                 "snakeCase",
#                 "SnakeCase",
#                 "_",
#                 "snake_Case",
#                 "_",
#                 "8",
#                 "Snake",
#                 "s_nake",
#                 "sn_ake",
#                 "_",
#                 "13",
#                 "14",
#                 "s_na_k_er",
#                 "_",
#                 "SNAKE SNAKE CASE",
#                 "_"
#                 )
#   
#   snake_case <- c(NA,
#                   "snake_case",
#                   "snake_case",
#                   "snake_case",
#                   "",
#                   "snake_case",
#                   "",
#                   "8",
#                   "snake",
#                   "s_nake",
#                   "sn_ake",
#                   "",
#                   "13",
#                   "14",
#                   "s_na_k_er",
#                   "",
#                   "snake_snake_case",
#                   ""
#                   )
#   
#   expect_equal(to_snake_case(examples),
#                snake_case)
# 
# })
context("to_snake_case")

test_that("basic usage1", {
  
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
  
  snake_case <- c(NA,
                  "snake_case",
                  "snake_case",
                  "snake_case",
                  "",
                  "snake_case",
                  "",
                  "s_nake",
                  "snake",
                  "s_nake",
                  "sn_ake",
                  "",
                  "s_na_ke",
                  "s_na_k_er",
                  "s_na_k_er",
                  "",
                  "snake_snake_case",
                  ""
  )
  
  expect_equal(to_snake_case(examples),
               snake_case)
  
})
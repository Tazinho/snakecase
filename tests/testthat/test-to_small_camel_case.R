context("to_small_camel_case")

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
                "_",
                "ssRRss",
                "ssRRRR"
  )
  
  small_camel_case <- c(NA, 
                        "snakeCase",
                        "snakeCase",
                        "snakeCase",
                        "",
                        "snakeCase",
                        "",
                        "sNake",
                        "snake",
                        "sNake",
                        "snAke",
                        "",
                        "sNaKe",
                        "sNaKEr",
                        "sNaKEr",
                        "",
                        "snakeSnakeCase",
                        "",
                        "ssRRss",
                        "ssRrrr")
  
  expect_equal(to_small_camel_case(examples),
               small_camel_case)
  expect_equal(to_small_camel_case(to_small_camel_case(examples)),
               to_small_camel_case(examples))
  
  expect_equal(to_small_camel_case(to_snake_case(to_small_camel_case(examples))),
               to_small_camel_case(examples))
  expect_equal(to_small_camel_case(to_big_camel_case(to_small_camel_case(examples))),
               to_small_camel_case(examples))
})
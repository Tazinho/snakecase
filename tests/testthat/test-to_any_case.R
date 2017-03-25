context("to_any_case")

test_that("examples", {
  examples <- cases[["examples"]]
  
  expect_equal(to_any_case(examples, case = "snake"),
               cases[["snake_case"]])
  
  expect_equal(to_any_case(examples, case = "small_camel"),
               cases[["small_camel_case"]])
  
  expect_equal(to_any_case(examples, case = "big_camel"),
               cases[["big_camel_case"]])
  
  expect_equal(to_any_case(examples, case = "screaming_snake"),
               cases[["screaming_snake_case"]])
  }
)

# test_that("rules",{
#   examples <- cases[["examples"]]
#   
#   expect_equal(to_snake_case(to_snake_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_small_camel_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_big_camel_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_screaming_snake_case(examples)),
#                to_snake_case(examples)
#   ) 
# })

test_that("complex strings", {
  strings2 <- c("this - Is_-: a Strange_string", "\u00C4ND THIS ANOTHER_One")
  
  expect_equal(to_any_case(strings2, case = "snake", preprocess = "-|\\:"),
               c("this_is_a_strange_string", "\u00E4nd_this_another_one"))
})
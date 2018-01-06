context("to_snake_case")

test_that("examples", {
  expect_equal(to_snake_case(cases[["examples"]]),
               cases[["snake_case"]])}
  )

test_that("rules",{
  examples <- cases[["examples"]]
  
  expect_equal(to_snake_case(to_snake_case(examples)),
               to_snake_case(examples)
               ) 
  expect_equal(to_snake_case(to_lower_camel_case(examples)),
               to_snake_case(examples)
  ) 
  expect_equal(to_snake_case(to_upper_camel_case(examples)),
               to_snake_case(examples)
  ) 
  expect_equal(to_snake_case(to_screaming_snake_case(examples)),
               to_snake_case(examples)
  ) 
  expect_equal(to_snake_case(to_parsed_case(examples)),
               to_snake_case(examples)
  ) 
})

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_snake_case(labs),
    structure(c("abc_def", "bbcc_ee", "te_e_st_it"), .Names = c("a", 
                                                                "b", "c"))
  )
})
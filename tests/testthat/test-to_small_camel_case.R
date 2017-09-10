context("to_small_camel_case")

test_that("examples", {
  expect_equal(to_small_camel_case(cases[["examples"]]),
               cases[["small_camel_case"]])}
)

test_that("rules",{
  examples <- cases[["examples"]]
  
  expect_equal(to_small_camel_case(to_snake_case(examples)),
               to_small_camel_case(examples)
  ) 
  expect_equal(to_small_camel_case(to_small_camel_case(examples)),
               to_small_camel_case(examples)
  ) 
  expect_equal(to_small_camel_case(to_big_camel_case(examples)),
               to_small_camel_case(examples)
  ) 
  expect_equal(to_small_camel_case(to_screaming_snake_case(examples)),
               to_small_camel_case(examples)
  ) 
  expect_equal(to_small_camel_case(to_parsed_case(examples)),
               to_small_camel_case(examples)
               )
})

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_small_camel_case(labs),
    structure(c("abcDef", "bbccEe", "teEStIt"), .Names = c("a", "b", 
                                                           "c"))
  )
})
context("to_big_camel_case")

test_that("examples", {
  expect_equal(to_big_camel_case(cases[["examples"]]),
               cases[["big_camel_case"]])}
)

test_that("rules",{
  examples <- cases[["examples"]]
  
  expect_equal(to_big_camel_case(to_snake_case(examples)),
               to_big_camel_case(examples)
  ) 
  expect_equal(to_big_camel_case(to_small_camel_case(examples)),
               to_big_camel_case(examples)
  ) 
  expect_equal(to_big_camel_case(to_big_camel_case(examples)),
               to_big_camel_case(examples)
  ) 
  expect_equal(to_big_camel_case(to_screaming_snake_case(examples)),
               to_big_camel_case(examples)
  ) 
  expect_equal(to_big_camel_case(to_parsed_case(examples)),
               to_big_camel_case(examples)
  ) 
})

test_that("preserve-names-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(to_big_camel_case(labs),
              structure(c("AbcDef", "BbccEe", "TeEStIt"), 
                        .Names = c("a", "b", "c")))
})
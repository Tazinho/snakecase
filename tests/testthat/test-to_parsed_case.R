context("to_parsed_case")

test_that("examples", {
  expect_equal(to_parsed_case(cases[["examples"]]),
               cases[["parsed_case"]])}
)

test_that("rules",{
  examples <- cases[["examples"]]
  # note that to parsed case has a little bit different rules than the other converters
  expect_equal(to_parsed_case(to_parsed_case(examples)),
               to_parsed_case(examples))
  
  expect_equal(to_parsed_case(to_snake_case(examples)),
               to_snake_case(examples)) 
  
  #expect_equal(to_parsed_case(to_small_camel_case(examples)),
  #             to_small_camel_case(examples))
  #
  #expect_equal(to_parsed_case(to_big_camel_case(examples)),
  #             to_big_camel_case(examples))
  
  expect_equal(to_parsed_case(to_screaming_snake_case(examples)),
               to_screaming_snake_case(examples)) 
})

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_parsed_case(labs),
    structure(c("abc_DEF", "bbcc_EE", "Te_E_St_it"), .Names = c("a", 
                                                                "b", "c"))
  )
})
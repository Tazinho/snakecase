context("to_upper_camel_case")

test_that("examples", {
  expect_equal(to_upper_camel_case(cases[["examples"]]),
               cases[["big_camel_case"]])}
)

test_that("rules",{
  examples <- cases[["examples"]]
  
  expect_equal(to_upper_camel_case(to_snake_case(examples)),
               to_upper_camel_case(examples)
  ) 
  expect_equal(to_upper_camel_case(to_lower_camel_case(examples)),
               to_upper_camel_case(examples)
  ) 
  expect_equal(to_upper_camel_case(to_upper_camel_case(examples)),
               to_upper_camel_case(examples)
  ) 
  expect_equal(to_upper_camel_case(to_screaming_snake_case(examples)),
               to_upper_camel_case(examples)
  ) 
  expect_equal(to_upper_camel_case(to_parsed_case(examples)),
               to_upper_camel_case(examples)
  ) 
})

test_that("preserve-names-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(to_upper_camel_case(labs),
              structure(c("AbcDef", "BbccEe", "TeEStIt"), 
                        .Names = c("a", "b", "c")))
})

test_that("parsing_options",{
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = 1, numerals = "asis", sep_in = NULL),
               "LookAfterThe-HyphenAndThe.Dot")
  
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = -1, numerals = "asis", sep_in = NULL),
               "LookAfterThe-hyphenAndThe.dot")
  
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = 2, numerals = "asis", sep_in = NULL),
               "LookAfterThe-HyphenAndThe.Dot")
  
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = -2, numerals = "asis", sep_in = NULL),
               "LookAfterThe-hyphenAndThe.dot")
  
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = 3, numerals = "asis", sep_in = NULL),
               "LookAfterThe-HyphenAndThe.Dot")
  
  expect_equal(to_upper_camel_case("look_AfterThe-hyphen andThe.dot", parsing_option = -3, numerals = "asis", sep_in = NULL),
               "LookAfterThe-hyphenAndThe.dot")
})
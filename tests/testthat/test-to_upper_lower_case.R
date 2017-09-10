context("to_upper_lower_case")

test_that("random stuff", {
  expect_equal(to_upper_lower_case("RStudioRRRStudio"),
               "RstudioRRRstudio")
  
  expect_equal(to_upper_lower_case(c("R.aStudio", NA, NA, NA, NA)),
               c("R.aSTUDIO", NA, NA, NA, NA))
  }
)

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_any_case(labs, case = "upper_lower"),
    structure(c("ABCdef", "BBCCee", "TEeSTit"), .Names = c("a", "b", 
                                                           "c"))
  )
})
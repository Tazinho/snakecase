context("to_upper_lower_case")

test_that("random stuff", {
  expect_equal(to_lower_upper_case("RStudioRRRStudio"),
               "rSTUDIOrrrSTUDIO")
  }
)

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_lower_upper_case(labs),
    structure(c("abcDEF", "bbccEE", "teEstIT"), .Names = c("a", "b", 
                                                           "c"))
  )
})
context("to_upper_lower_case")

test_that("random stuff", {
  expect_equal(to_upper_lower_case("RStudioRRRStudio"),
               "RstudioRRRstudio")
  
  expect_equal(to_upper_lower_case(c("R.aStudio", NA, NA, NA, NA)),
               c("R.aSTUDIO", NA, NA, NA, NA))
  }
)

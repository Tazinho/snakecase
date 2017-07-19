context("to_mixed_case")

test_that("random stuff", {
  expect_equal(to_mixed_case("RStudioRRRStudio"),
               "R_Studio_Rrr_Studio")
  }
)

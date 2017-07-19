context("to_upper_lower_case")

test_that("random stuff", {
  expect_equal(to_upper_lower_case("RStudioRRRStudio"),
               "RstudioRRRstudio")}
)

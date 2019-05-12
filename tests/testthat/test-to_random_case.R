test_that("random_case", {
  expect_equal(
    {RNGversion("3.1");set.seed(123); to_random_case("almost RANDOM")},
    "AlMosT raNdOm"
  )
})
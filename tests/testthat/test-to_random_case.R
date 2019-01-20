test_that("random_case", {
  expect_equal(
    {set.seed(123); to_random_case("almost RANDOM")},
    "AlMosT raNdOm"
  )
})
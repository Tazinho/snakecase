context("to_swap_case")

test_that("minimal test",{
  
  expect_equal(
    to_swap_case(c("abCD", "RStudio")),
    c("ABcd", "rsTUDIO")
  )
})
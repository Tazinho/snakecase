context("to_mixed_case")

test_that("random stuff", {
  expect_equal(to_mixed_case("RStudioRRRStudio"),
               "R_Studio_Rrr_Studio")
  }
)

test_that("preserve-name-attribute",{
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_mixed_case(labs),
    structure(c("abc_Def", "bbcc_Ee", "Te_E_St_it"), .Names = c("a", 
                                                                "b", "c"))
  )
})
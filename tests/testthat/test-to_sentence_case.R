context("to_sentence_case")

test_that("basic_example",{
  
  expect_equal(
    to_sentence_case("bla bla_bal"),
    "Bla bla bal")
})
context("to_sentence_case")

test_that("basic_example",{
  
  expect_equal(
    to_sentence_case("bla bla_bal"),
    "Bla bla bal")
  
  expect_equal(to_sentence_case("the_boy_likes_snake_case",
                                transliterations = c("boy" = "baby",
                                                     "snake" = "screaming__snake"),
                                sep_out = " "),
               "The baby likes screaming snake case")
  
  expect_equal(to_sentence_case("the_boy_likes_snake_case",
                       transliterations = c("boy" = "baby",
                                            "snake" = "screaming__snake")),
    "The baby likes screaming snake case")
})
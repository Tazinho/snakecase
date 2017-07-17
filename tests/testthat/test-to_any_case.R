context("to_any_case")

test_that("examples", {
  examples <- cases[["examples"]]
  
  expect_equal(to_any_case(examples, case = "snake"),
               cases[["snake_case"]])
  
  expect_equal(to_any_case(examples, case = "small_camel"),
               cases[["small_camel_case"]])
  
  expect_equal(to_any_case(examples, case = "big_camel"),
               cases[["big_camel_case"]])
  
  expect_equal(to_any_case(examples, case = "screaming_snake"),
               cases[["screaming_snake_case"]])
  
  expect_equal(to_any_case(examples, case = "parsed"),
             cases[["parsed_case"]])
  
  expect_equal(to_any_case("R.Studio", case = "big_camel", protect = "\\.", postprocess = "-"),
               "R.Studio")
}
)

# test_that("rules",{
#   examples <- cases[["examples"]]
#   
#   expect_equal(to_snake_case(to_snake_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_small_camel_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_big_camel_case(examples)),
#                to_snake_case(examples)
#   ) 
#   expect_equal(to_snake_case(to_screaming_snake_case(examples)),
#                to_snake_case(examples)
#   ) 
# })

test_that("random examples", 
          expect_equal(to_any_case("string123", case = "snake"),
                       "string_123"))

test_that("complex strings", {
  strings2 <- c("this - Is_-: a Strange_string", "\u00C4ND THIS ANOTHER_One")
  
  expect_equal(to_any_case(strings2, case = "snake", preprocess = "-|\\:"),
               c("this_is_a_strange_string", "\u00E4nd_this_another_one"))
  
  expect_equal(to_any_case("MERKWUERDIGER-VariablenNAME mit.VIELENMustern_version: 3.7.4",
                           case = "snake",
                           preprocess = "-|:|(?<!\\d)\\.",
                           protect = "\\.",
                           postprocess = "."),
               "merkwuerdiger.variablen.name.mit.vielen.mustern.version.3.7.4")
  
  expect_equal(to_any_case("R.Studio", case = "big_camel", protect = "\\."),
               c("R.Studio"))
  
  expect_equal(to_any_case("R.Studio: v 1.0.143", case = "big_camel", preprocess = "\\.", postprocess = "_", protect = ":"),
               "R_Studio:V_1_0_143")
  
  expect_equal(to_any_case("R.aStudio", case = "snake", protect = "\\.|A", postprocess = "-"), "r.a-studio")
  expect_equal(to_any_case("R.aStudio", case = "snake", protect = "\\.|a", postprocess = "-"), "r.astudio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", protect = "\\.|A", postprocess = "-"), "R.A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", protect = "\\.|a", postprocess = "-"), "R.AStudio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", protect = "\\.|A", postprocess = "-"), "r.A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", protect = "\\.|a", postprocess = "-"), "r.AStudio")
  expect_equal(to_any_case("r.aStudio", protect = "a", postprocess = "-", case = "big_camel"), "R-.AStudio")
  
  expect_equal(to_any_case("rStudio", case = "none", prefix = "rrr."),
               "rrr.rStudio")
  
  expect_equal(to_any_case("Rstudio_STudio_sssTTT", case = "mixed"),
               "Rstudio_S_Tudio_sss_Ttt")
  expect_equal(to_any_case("Rstudio_STudio_sssTTT", case = "mixed", parsingoption = 2),
               "Rstudio_St_udio_sss_Ttt")
  
  expect_equal(to_any_case(names(iris), case = "lower_upper", preprocess = "\\.", postprocess = "-"),
               c("sepal-LENGTH", "sepal-WIDTH", "petal-LENGTH", "petal-WIDTH", "species"))
  
  expect_equal(to_any_case("R.aStudio", case = "lower_upper"),
               "r.Astudio")
  expect_equal(to_any_case("R.aStudio", case = "upper_lower"),
               "R.aSTUDIO")
  
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", protect = "\\."),
               "r.Astudio")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", protect = "\\.|a", postprocess = "-"),
               "r.Astudio")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", protect = "\\.|A", postprocess = "-"),
               "r.A-studio")
  
  expect_equal(to_any_case("rstudio", case = "all_caps"),
               "RSTUDIO")
  expect_equal(to_any_case("rstudio", case = "upper_camel"),
               "Rstudio")
  expect_equal(to_any_case("rstudio", case = "lower_camel"),
               "rstudio")
  expect_equal(to_any_case("bla rstudio", case = "lower_camel"),
               "blaRstudio")
  
  expect_equal(to_any_case("R.aStudio", case = "parsed", protect = "\\.|A", postprocess = "-"),
               "R.a-Studio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", protect = "\\.|A", postprocess = "-"),
               "r.A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", protect = "\\.|A", postprocess = "-"),
               "R.A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "screaming_snake", protect = "\\.|A", postprocess = "-"),
               "R.A-STUDIO")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", protect = "\\.|A", postprocess = "-"),
               "r.A-studio")
  expect_equal(to_any_case("R.aStudio", case = "upper_lower", protect = "\\.|A", postprocess = "-"),
               "R.a-STUDIO")
  expect_equal(to_any_case("R.aStudio", case = "none", protect = "\\.|A", postprocess = "-"),
               "R.aStudio")
  expect_equal(to_any_case("R.aStudio", case = "mixed", protect = "\\.|A", postprocess = "-"),
               "R.a-Studio")
  
  expect_equal(to_any_case(character(0), postprocess = "c"), "")
  
  expect_equal(to_any_case("fdf 1 2", protect = "\\d", case = "big_camel"),
               "Fdf12")
  
  # expect_equal(to_any_case(c(NA, NA, NA), "lower_upper"),
  #              rep(NA_character_, 3))
  # 
  # expect_equal(to_any_case(c(NA, NA, NA), "upper_lower"),
  #              rep(NA_character_, 3))
})


test_that("stackoverflow answers", {
  expect_equal(to_any_case(c("ThisText", "NextText"), case = "snake", postprocess = "\\."),
               c("this.text", "next.text"))
  
  expect_equal(to_any_case(c("BobDylanUSA",
                             "MikhailGorbachevUSSR",
                             "HelpfulStackOverflowPeople",
                             "IAmATallDrinkOfWater"),
                           case = "parsed",
                           postprocess = " "),
               c("Bob Dylan USA", "Mikhail Gorbachev USSR",
                 "Helpful Stack Overflow People", "I Am A Tall Drink Of Water"))
  
  expect_equal(to_any_case(c("ICUDays","SexCode","MAX_of_MLD","Age.Group"),
                           case = "snake",
                           preprocess = "\\."),
               c("icu_days", "sex_code", "max_of_mld", "age_group")) 

  expect_equal(to_any_case(c("ICUDays","SexCode","MAX_of_MLD","Age.Group"),
                           case = "small_camel",
                           preprocess = "\\."),
               c("icuDays", "sexCode", "maxOfMld", "ageGroup")) 
  
  expect_equal(unlist(strsplit(to_parsed_case("thisIsSomeCamelCase"), "_")),
               c("this", "Is", "Some", "Camel", "Case"))
  
  expect_equal(to_any_case(c("zip code", "state", "final count"),
                           case = "big_camel",
                           postprocess = " "),
               c("Zip Code", "State", "Final Count"))
  
  expect_equal(to_any_case(c("this.text", "next.text"),
                           case = "big_camel", 
                           preprocess = "\\."),
               c("ThisText", "NextText"))
})

test_that("parsing cases", {
  expect_equal(to_any_case("RRRStudio", case = "parsed"), 
               "RRR_Studio")
  
  expect_equal(to_any_case("RRRStudio", case = "parsed", parsingoption = 1), 
               "RRR_Studio")

  expect_equal(to_any_case("RRRStudio", case = "parsed", parsingoption = 2), 
               "RRRS_tudio")
  
  expect_equal(check_design_rule("RRRStudio", parsingoption = 1),
               TRUE)
  
  expect_equal(check_design_rule("RRRStudio", parsingoption = 2),
               TRUE)
  })

test_that("expand.grid", {
  # string <- c(NA, "_", "s_na_k_er", "SNAKE SNAKE CASE", "snakeSnakECase",
  #             "SNAKE snakE_case", "ssRRss", "ssRRRR", "thisIsSomeCamelCase",
  #             "this.text", "final count", "BobDylanUSA", "MikhailGorbachevUSSR",
  #             "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "ICUDays", "SexCode",
  #             "MAX_of_MLD", "Age.Group")
  # case <- c("parsed", "snake", "small_camel", "big_camel", "screaming_snake")
  # prefix <- c("", "start.")
  # postfix <- c("", ".end")
  # replace_special_characters <- c(TRUE, FALSE)
  # 
  # dat <- expand.grid(string = string,
  #                    case = case,
  #                    postfix = postfix,
  #                    prefix = prefix,
  #                    replace_special_characters = replace_special_characters,
  #                    stringsAsFactors = FALSE)
  expect_equal(purrrlyr::invoke_rows(snakecase::to_any_case, dat,
                     preprocess = NULL,
                     postprocess = NULL,
                     protect = NULL,
                     .collate = "cols",
                     .to = "output") %>% .$output, #%>% dput
               c(NA, "", "s_na_k_er", "SNAKE_SNAKE_CASE", "snake_Snak_E_Case", 
                 "SNAKE_snak_E_case", "ss_R_Rss", "ss_RRRR", "this_Is_Some_Camel_Case", 
                 "this_._text", "final_count", "Bob_Dylan_USA", "Mikhail_Gorbachev_USSR", 
                 "Helpful_Stack_Overflow_People", "Im_A_Tall_Drink_Of_Water", 
                 "ICU_Days", "Sex_Code", "MAX_of_MLD", "Age_._Group", NA, "", 
                 "s_na_k_er", "snake_snake_case", "snake_snak_e_case", "snake_snak_e_case", 
                 "ss_r_rss", "ss_rrrr", "this_is_some_camel_case", "this_._text", 
                 "final_count", "bob_dylan_usa", "mikhail_gorbachev_ussr", "helpful_stack_overflow_people", 
                 "im_a_tall_drink_of_water", "icu_days", "sex_code", "max_of_mld", 
                 "age_._group", NA, "", "sNaKEr", "snakeSnakeCase", "snakeSnakECase", 
                 "snakeSnakECase", "ssRRss", "ssRrrr", "thisIsSomeCamelCase", 
                 "this.Text", "finalCount", "bobDylanUsa", "mikhailGorbachevUssr", 
                 "helpfulStackOverflowPeople", "imATallDrinkOfWater", "icuDays", 
                 "sexCode", "maxOfMld", "age.Group", NA, "", "SNaKEr", "SnakeSnakeCase", 
                 "SnakeSnakECase", "SnakeSnakECase", "SsRRss", "SsRrrr", "ThisIsSomeCamelCase", 
                 "This.Text", "FinalCount", "BobDylanUsa", "MikhailGorbachevUssr", 
                 "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "IcuDays", 
                 "SexCode", "MaxOfMld", "Age.Group", NA, "", "S_NA_K_ER", "SNAKE_SNAKE_CASE", 
                 "SNAKE_SNAK_E_CASE", "SNAKE_SNAK_E_CASE", "SS_R_RSS", "SS_RRRR", 
                 "THIS_IS_SOME_CAMEL_CASE", "THIS_._TEXT", "FINAL_COUNT", "BOB_DYLAN_USA", 
                 "MIKHAIL_GORBACHEV_USSR", "HELPFUL_STACK_OVERFLOW_PEOPLE", "IM_A_TALL_DRINK_OF_WATER", 
                 "ICU_DAYS", "SEX_CODE", "MAX_OF_MLD", "AGE_._GROUP", NA, ".end", 
                 "s_na_k_er.end", "SNAKE_SNAKE_CASE.end", "snake_Snak_E_Case.end", 
                 "SNAKE_snak_E_case.end", "ss_R_Rss.end", "ss_RRRR.end", "this_Is_Some_Camel_Case.end", 
                 "this_._text.end", "final_count.end", "Bob_Dylan_USA.end", "Mikhail_Gorbachev_USSR.end", 
                 "Helpful_Stack_Overflow_People.end", "Im_A_Tall_Drink_Of_Water.end", 
                 "ICU_Days.end", "Sex_Code.end", "MAX_of_MLD.end", "Age_._Group.end", 
                 NA, ".end", "s_na_k_er.end", "snake_snake_case.end", "snake_snak_e_case.end", 
                 "snake_snak_e_case.end", "ss_r_rss.end", "ss_rrrr.end", "this_is_some_camel_case.end", 
                 "this_._text.end", "final_count.end", "bob_dylan_usa.end", "mikhail_gorbachev_ussr.end", 
                 "helpful_stack_overflow_people.end", "im_a_tall_drink_of_water.end", 
                 "icu_days.end", "sex_code.end", "max_of_mld.end", "age_._group.end", 
                 NA, ".end", "sNaKEr.end", "snakeSnakeCase.end", "snakeSnakECase.end", 
                 "snakeSnakECase.end", "ssRRss.end", "ssRrrr.end", "thisIsSomeCamelCase.end", 
                 "this.Text.end", "finalCount.end", "bobDylanUsa.end", "mikhailGorbachevUssr.end", 
                 "helpfulStackOverflowPeople.end", "imATallDrinkOfWater.end", 
                 "icuDays.end", "sexCode.end", "maxOfMld.end", "age.Group.end", 
                 NA, ".end", "SNaKEr.end", "SnakeSnakeCase.end", "SnakeSnakECase.end", 
                 "SnakeSnakECase.end", "SsRRss.end", "SsRrrr.end", "ThisIsSomeCamelCase.end", 
                 "This.Text.end", "FinalCount.end", "BobDylanUsa.end", "MikhailGorbachevUssr.end", 
                 "HelpfulStackOverflowPeople.end", "ImATallDrinkOfWater.end", 
                 "IcuDays.end", "SexCode.end", "MaxOfMld.end", "Age.Group.end", 
                 NA, ".end", "S_NA_K_ER.end", "SNAKE_SNAKE_CASE.end", "SNAKE_SNAK_E_CASE.end", 
                 "SNAKE_SNAK_E_CASE.end", "SS_R_RSS.end", "SS_RRRR.end", "THIS_IS_SOME_CAMEL_CASE.end", 
                 "THIS_._TEXT.end", "FINAL_COUNT.end", "BOB_DYLAN_USA.end", "MIKHAIL_GORBACHEV_USSR.end", 
                 "HELPFUL_STACK_OVERFLOW_PEOPLE.end", "IM_A_TALL_DRINK_OF_WATER.end", 
                 "ICU_DAYS.end", "SEX_CODE.end", "MAX_OF_MLD.end", "AGE_._GROUP.end", 
                 NA, "start.", "start.s_na_k_er", "start.SNAKE_SNAKE_CASE", "start.snake_Snak_E_Case", 
                 "start.SNAKE_snak_E_case", "start.ss_R_Rss", "start.ss_RRRR", 
                 "start.this_Is_Some_Camel_Case", "start.this_._text", "start.final_count", 
                 "start.Bob_Dylan_USA", "start.Mikhail_Gorbachev_USSR", "start.Helpful_Stack_Overflow_People", 
                 "start.Im_A_Tall_Drink_Of_Water", "start.ICU_Days", "start.Sex_Code", 
                 "start.MAX_of_MLD", "start.Age_._Group", NA, "start.", "start.s_na_k_er", 
                 "start.snake_snake_case", "start.snake_snak_e_case", "start.snake_snak_e_case", 
                 "start.ss_r_rss", "start.ss_rrrr", "start.this_is_some_camel_case", 
                 "start.this_._text", "start.final_count", "start.bob_dylan_usa", 
                 "start.mikhail_gorbachev_ussr", "start.helpful_stack_overflow_people", 
                 "start.im_a_tall_drink_of_water", "start.icu_days", "start.sex_code", 
                 "start.max_of_mld", "start.age_._group", NA, "start.", "start.sNaKEr", 
                 "start.snakeSnakeCase", "start.snakeSnakECase", "start.snakeSnakECase", 
                 "start.ssRRss", "start.ssRrrr", "start.thisIsSomeCamelCase", 
                 "start.this.Text", "start.finalCount", "start.bobDylanUsa", "start.mikhailGorbachevUssr", 
                 "start.helpfulStackOverflowPeople", "start.imATallDrinkOfWater", 
                 "start.icuDays", "start.sexCode", "start.maxOfMld", "start.age.Group", 
                 NA, "start.", "start.SNaKEr", "start.SnakeSnakeCase", "start.SnakeSnakECase", 
                 "start.SnakeSnakECase", "start.SsRRss", "start.SsRrrr", "start.ThisIsSomeCamelCase", 
                 "start.This.Text", "start.FinalCount", "start.BobDylanUsa", "start.MikhailGorbachevUssr", 
                 "start.HelpfulStackOverflowPeople", "start.ImATallDrinkOfWater", 
                 "start.IcuDays", "start.SexCode", "start.MaxOfMld", "start.Age.Group", 
                 NA, "start.", "start.S_NA_K_ER", "start.SNAKE_SNAKE_CASE", "start.SNAKE_SNAK_E_CASE", 
                 "start.SNAKE_SNAK_E_CASE", "start.SS_R_RSS", "start.SS_RRRR", 
                 "start.THIS_IS_SOME_CAMEL_CASE", "start.THIS_._TEXT", "start.FINAL_COUNT", 
                 "start.BOB_DYLAN_USA", "start.MIKHAIL_GORBACHEV_USSR", "start.HELPFUL_STACK_OVERFLOW_PEOPLE", 
                 "start.IM_A_TALL_DRINK_OF_WATER", "start.ICU_DAYS", "start.SEX_CODE", 
                 "start.MAX_OF_MLD", "start.AGE_._GROUP", NA, "start..end", "start.s_na_k_er.end", 
                 "start.SNAKE_SNAKE_CASE.end", "start.snake_Snak_E_Case.end", 
                 "start.SNAKE_snak_E_case.end", "start.ss_R_Rss.end", "start.ss_RRRR.end", 
                 "start.this_Is_Some_Camel_Case.end", "start.this_._text.end", 
                 "start.final_count.end", "start.Bob_Dylan_USA.end", "start.Mikhail_Gorbachev_USSR.end", 
                 "start.Helpful_Stack_Overflow_People.end", "start.Im_A_Tall_Drink_Of_Water.end", 
                 "start.ICU_Days.end", "start.Sex_Code.end", "start.MAX_of_MLD.end", 
                 "start.Age_._Group.end", NA, "start..end", "start.s_na_k_er.end", 
                 "start.snake_snake_case.end", "start.snake_snak_e_case.end", 
                 "start.snake_snak_e_case.end", "start.ss_r_rss.end", "start.ss_rrrr.end", 
                 "start.this_is_some_camel_case.end", "start.this_._text.end", 
                 "start.final_count.end", "start.bob_dylan_usa.end", "start.mikhail_gorbachev_ussr.end", 
                 "start.helpful_stack_overflow_people.end", "start.im_a_tall_drink_of_water.end", 
                 "start.icu_days.end", "start.sex_code.end", "start.max_of_mld.end", 
                 "start.age_._group.end", NA, "start..end", "start.sNaKEr.end", 
                 "start.snakeSnakeCase.end", "start.snakeSnakECase.end", "start.snakeSnakECase.end", 
                 "start.ssRRss.end", "start.ssRrrr.end", "start.thisIsSomeCamelCase.end", 
                 "start.this.Text.end", "start.finalCount.end", "start.bobDylanUsa.end", 
                 "start.mikhailGorbachevUssr.end", "start.helpfulStackOverflowPeople.end", 
                 "start.imATallDrinkOfWater.end", "start.icuDays.end", "start.sexCode.end", 
                 "start.maxOfMld.end", "start.age.Group.end", NA, "start..end", 
                 "start.SNaKEr.end", "start.SnakeSnakeCase.end", "start.SnakeSnakECase.end", 
                 "start.SnakeSnakECase.end", "start.SsRRss.end", "start.SsRrrr.end", 
                 "start.ThisIsSomeCamelCase.end", "start.This.Text.end", "start.FinalCount.end", 
                 "start.BobDylanUsa.end", "start.MikhailGorbachevUssr.end", "start.HelpfulStackOverflowPeople.end", 
                 "start.ImATallDrinkOfWater.end", "start.IcuDays.end", "start.SexCode.end", 
                 "start.MaxOfMld.end", "start.Age.Group.end", NA, "start..end", 
                 "start.S_NA_K_ER.end", "start.SNAKE_SNAKE_CASE.end", "start.SNAKE_SNAK_E_CASE.end", 
                 "start.SNAKE_SNAK_E_CASE.end", "start.SS_R_RSS.end", "start.SS_RRRR.end", 
                 "start.THIS_IS_SOME_CAMEL_CASE.end", "start.THIS_._TEXT.end", 
                 "start.FINAL_COUNT.end", "start.BOB_DYLAN_USA.end", "start.MIKHAIL_GORBACHEV_USSR.end", 
                 "start.HELPFUL_STACK_OVERFLOW_PEOPLE.end", "start.IM_A_TALL_DRINK_OF_WATER.end", 
                 "start.ICU_DAYS.end", "start.SEX_CODE.end", "start.MAX_OF_MLD.end", 
                 "start.AGE_._GROUP.end", NA, "", "s_na_k_er", "SNAKE_SNAKE_CASE", 
                 "snake_Snak_E_Case", "SNAKE_snak_E_case", "ss_R_Rss", "ss_RRRR", 
                 "this_Is_Some_Camel_Case", "this_._text", "final_count", "Bob_Dylan_USA", 
                 "Mikhail_Gorbachev_USSR", "Helpful_Stack_Overflow_People", "Im_A_Tall_Drink_Of_Water", 
                 "ICU_Days", "Sex_Code", "MAX_of_MLD", "Age_._Group", NA, "", 
                 "s_na_k_er", "snake_snake_case", "snake_snak_e_case", "snake_snak_e_case", 
                 "ss_r_rss", "ss_rrrr", "this_is_some_camel_case", "this_._text", 
                 "final_count", "bob_dylan_usa", "mikhail_gorbachev_ussr", "helpful_stack_overflow_people", 
                 "im_a_tall_drink_of_water", "icu_days", "sex_code", "max_of_mld", 
                 "age_._group", NA, "", "sNaKEr", "snakeSnakeCase", "snakeSnakECase", 
                 "snakeSnakECase", "ssRRss", "ssRrrr", "thisIsSomeCamelCase", 
                 "this.Text", "finalCount", "bobDylanUsa", "mikhailGorbachevUssr", 
                 "helpfulStackOverflowPeople", "imATallDrinkOfWater", "icuDays", 
                 "sexCode", "maxOfMld", "age.Group", NA, "", "SNaKEr", "SnakeSnakeCase", 
                 "SnakeSnakECase", "SnakeSnakECase", "SsRRss", "SsRrrr", "ThisIsSomeCamelCase", 
                 "This.Text", "FinalCount", "BobDylanUsa", "MikhailGorbachevUssr", 
                 "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "IcuDays", 
                 "SexCode", "MaxOfMld", "Age.Group", NA, "", "S_NA_K_ER", "SNAKE_SNAKE_CASE", 
                 "SNAKE_SNAK_E_CASE", "SNAKE_SNAK_E_CASE", "SS_R_RSS", "SS_RRRR", 
                 "THIS_IS_SOME_CAMEL_CASE", "THIS_._TEXT", "FINAL_COUNT", "BOB_DYLAN_USA", 
                 "MIKHAIL_GORBACHEV_USSR", "HELPFUL_STACK_OVERFLOW_PEOPLE", "IM_A_TALL_DRINK_OF_WATER", 
                 "ICU_DAYS", "SEX_CODE", "MAX_OF_MLD", "AGE_._GROUP", NA, ".end", 
                 "s_na_k_er.end", "SNAKE_SNAKE_CASE.end", "snake_Snak_E_Case.end", 
                 "SNAKE_snak_E_case.end", "ss_R_Rss.end", "ss_RRRR.end", "this_Is_Some_Camel_Case.end", 
                 "this_._text.end", "final_count.end", "Bob_Dylan_USA.end", "Mikhail_Gorbachev_USSR.end", 
                 "Helpful_Stack_Overflow_People.end", "Im_A_Tall_Drink_Of_Water.end", 
                 "ICU_Days.end", "Sex_Code.end", "MAX_of_MLD.end", "Age_._Group.end", 
                 NA, ".end", "s_na_k_er.end", "snake_snake_case.end", "snake_snak_e_case.end", 
                 "snake_snak_e_case.end", "ss_r_rss.end", "ss_rrrr.end", "this_is_some_camel_case.end", 
                 "this_._text.end", "final_count.end", "bob_dylan_usa.end", "mikhail_gorbachev_ussr.end", 
                 "helpful_stack_overflow_people.end", "im_a_tall_drink_of_water.end", 
                 "icu_days.end", "sex_code.end", "max_of_mld.end", "age_._group.end", 
                 NA, ".end", "sNaKEr.end", "snakeSnakeCase.end", "snakeSnakECase.end", 
                 "snakeSnakECase.end", "ssRRss.end", "ssRrrr.end", "thisIsSomeCamelCase.end", 
                 "this.Text.end", "finalCount.end", "bobDylanUsa.end", "mikhailGorbachevUssr.end", 
                 "helpfulStackOverflowPeople.end", "imATallDrinkOfWater.end", 
                 "icuDays.end", "sexCode.end", "maxOfMld.end", "age.Group.end", 
                 NA, ".end", "SNaKEr.end", "SnakeSnakeCase.end", "SnakeSnakECase.end", 
                 "SnakeSnakECase.end", "SsRRss.end", "SsRrrr.end", "ThisIsSomeCamelCase.end", 
                 "This.Text.end", "FinalCount.end", "BobDylanUsa.end", "MikhailGorbachevUssr.end", 
                 "HelpfulStackOverflowPeople.end", "ImATallDrinkOfWater.end", 
                 "IcuDays.end", "SexCode.end", "MaxOfMld.end", "Age.Group.end", 
                 NA, ".end", "S_NA_K_ER.end", "SNAKE_SNAKE_CASE.end", "SNAKE_SNAK_E_CASE.end", 
                 "SNAKE_SNAK_E_CASE.end", "SS_R_RSS.end", "SS_RRRR.end", "THIS_IS_SOME_CAMEL_CASE.end", 
                 "THIS_._TEXT.end", "FINAL_COUNT.end", "BOB_DYLAN_USA.end", "MIKHAIL_GORBACHEV_USSR.end", 
                 "HELPFUL_STACK_OVERFLOW_PEOPLE.end", "IM_A_TALL_DRINK_OF_WATER.end", 
                 "ICU_DAYS.end", "SEX_CODE.end", "MAX_OF_MLD.end", "AGE_._GROUP.end", 
                 NA, "start.", "start.s_na_k_er", "start.SNAKE_SNAKE_CASE", "start.snake_Snak_E_Case", 
                 "start.SNAKE_snak_E_case", "start.ss_R_Rss", "start.ss_RRRR", 
                 "start.this_Is_Some_Camel_Case", "start.this_._text", "start.final_count", 
                 "start.Bob_Dylan_USA", "start.Mikhail_Gorbachev_USSR", "start.Helpful_Stack_Overflow_People", 
                 "start.Im_A_Tall_Drink_Of_Water", "start.ICU_Days", "start.Sex_Code", 
                 "start.MAX_of_MLD", "start.Age_._Group", NA, "start.", "start.s_na_k_er", 
                 "start.snake_snake_case", "start.snake_snak_e_case", "start.snake_snak_e_case", 
                 "start.ss_r_rss", "start.ss_rrrr", "start.this_is_some_camel_case", 
                 "start.this_._text", "start.final_count", "start.bob_dylan_usa", 
                 "start.mikhail_gorbachev_ussr", "start.helpful_stack_overflow_people", 
                 "start.im_a_tall_drink_of_water", "start.icu_days", "start.sex_code", 
                 "start.max_of_mld", "start.age_._group", NA, "start.", "start.sNaKEr", 
                 "start.snakeSnakeCase", "start.snakeSnakECase", "start.snakeSnakECase", 
                 "start.ssRRss", "start.ssRrrr", "start.thisIsSomeCamelCase", 
                 "start.this.Text", "start.finalCount", "start.bobDylanUsa", "start.mikhailGorbachevUssr", 
                 "start.helpfulStackOverflowPeople", "start.imATallDrinkOfWater", 
                 "start.icuDays", "start.sexCode", "start.maxOfMld", "start.age.Group", 
                 NA, "start.", "start.SNaKEr", "start.SnakeSnakeCase", "start.SnakeSnakECase", 
                 "start.SnakeSnakECase", "start.SsRRss", "start.SsRrrr", "start.ThisIsSomeCamelCase", 
                 "start.This.Text", "start.FinalCount", "start.BobDylanUsa", "start.MikhailGorbachevUssr", 
                 "start.HelpfulStackOverflowPeople", "start.ImATallDrinkOfWater", 
                 "start.IcuDays", "start.SexCode", "start.MaxOfMld", "start.Age.Group", 
                 NA, "start.", "start.S_NA_K_ER", "start.SNAKE_SNAKE_CASE", "start.SNAKE_SNAK_E_CASE", 
                 "start.SNAKE_SNAK_E_CASE", "start.SS_R_RSS", "start.SS_RRRR", 
                 "start.THIS_IS_SOME_CAMEL_CASE", "start.THIS_._TEXT", "start.FINAL_COUNT", 
                 "start.BOB_DYLAN_USA", "start.MIKHAIL_GORBACHEV_USSR", "start.HELPFUL_STACK_OVERFLOW_PEOPLE", 
                 "start.IM_A_TALL_DRINK_OF_WATER", "start.ICU_DAYS", "start.SEX_CODE", 
                 "start.MAX_OF_MLD", "start.AGE_._GROUP", NA, "start..end", "start.s_na_k_er.end", 
                 "start.SNAKE_SNAKE_CASE.end", "start.snake_Snak_E_Case.end", 
                 "start.SNAKE_snak_E_case.end", "start.ss_R_Rss.end", "start.ss_RRRR.end", 
                 "start.this_Is_Some_Camel_Case.end", "start.this_._text.end", 
                 "start.final_count.end", "start.Bob_Dylan_USA.end", "start.Mikhail_Gorbachev_USSR.end", 
                 "start.Helpful_Stack_Overflow_People.end", "start.Im_A_Tall_Drink_Of_Water.end", 
                 "start.ICU_Days.end", "start.Sex_Code.end", "start.MAX_of_MLD.end", 
                 "start.Age_._Group.end", NA, "start..end", "start.s_na_k_er.end", 
                 "start.snake_snake_case.end", "start.snake_snak_e_case.end", 
                 "start.snake_snak_e_case.end", "start.ss_r_rss.end", "start.ss_rrrr.end", 
                 "start.this_is_some_camel_case.end", "start.this_._text.end", 
                 "start.final_count.end", "start.bob_dylan_usa.end", "start.mikhail_gorbachev_ussr.end", 
                 "start.helpful_stack_overflow_people.end", "start.im_a_tall_drink_of_water.end", 
                 "start.icu_days.end", "start.sex_code.end", "start.max_of_mld.end", 
                 "start.age_._group.end", NA, "start..end", "start.sNaKEr.end", 
                 "start.snakeSnakeCase.end", "start.snakeSnakECase.end", "start.snakeSnakECase.end", 
                 "start.ssRRss.end", "start.ssRrrr.end", "start.thisIsSomeCamelCase.end", 
                 "start.this.Text.end", "start.finalCount.end", "start.bobDylanUsa.end", 
                 "start.mikhailGorbachevUssr.end", "start.helpfulStackOverflowPeople.end", 
                 "start.imATallDrinkOfWater.end", "start.icuDays.end", "start.sexCode.end", 
                 "start.maxOfMld.end", "start.age.Group.end", NA, "start..end", 
                 "start.SNaKEr.end", "start.SnakeSnakeCase.end", "start.SnakeSnakECase.end", 
                 "start.SnakeSnakECase.end", "start.SsRRss.end", "start.SsRrrr.end", 
                 "start.ThisIsSomeCamelCase.end", "start.This.Text.end", "start.FinalCount.end", 
                 "start.BobDylanUsa.end", "start.MikhailGorbachevUssr.end", "start.HelpfulStackOverflowPeople.end", 
                 "start.ImATallDrinkOfWater.end", "start.IcuDays.end", "start.SexCode.end", 
                 "start.MaxOfMld.end", "start.Age.Group.end", NA, "start..end", 
                 "start.S_NA_K_ER.end", "start.SNAKE_SNAKE_CASE.end", "start.SNAKE_SNAK_E_CASE.end", 
                 "start.SNAKE_SNAK_E_CASE.end", "start.SS_R_RSS.end", "start.SS_RRRR.end", 
                 "start.THIS_IS_SOME_CAMEL_CASE.end", "start.THIS_._TEXT.end", 
                 "start.FINAL_COUNT.end", "start.BOB_DYLAN_USA.end", "start.MIKHAIL_GORBACHEV_USSR.end", 
                 "start.HELPFUL_STACK_OVERFLOW_PEOPLE.end", "start.IM_A_TALL_DRINK_OF_WATER.end", 
                 "start.ICU_DAYS.end", "start.SEX_CODE.end", "start.MAX_OF_MLD.end", 
                 "start.AGE_._GROUP.end"))
  }
)
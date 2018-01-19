# cases for examples
cases <-
  tibble::tribble(
    ~nr, ~ examples                  ,~parsed_case                    , ~snake_case                  , ~small_camel_case            , ~big_camel_case              , ~screaming_snake_case ,
    #--|-----------------------------,--------------------------------|------------------------------|------------------------------|------------------------------|-----------------------|
    1  , NA                          , NA                             , NA                             , NA                           , NA                           , NA,
    2  , "snake_case"                , "snake_case"                   , "snake_case"                   , "snakeCase"                  , "SnakeCase"                  , "SNAKE_CASE",
    3  , "snakeCase"                 , "snake_Case"                   , "snake_case"                   , "snakeCase"                  , "SnakeCase"                  , "SNAKE_CASE",
    4  , "SnakeCase"                 , "Snake_Case"                   , "snake_case"                   , "snakeCase"                  , "SnakeCase"                  , "SNAKE_CASE",
    5  , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    6  , "snake_Case"                , "snake_Case"                   , "snake_case"                   , "snakeCase"                  , "SnakeCase"                  , "SNAKE_CASE",
    7  , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    8  , "SNake"                     , "S_Nake"                       , "s_nake"                       , "sNake"                      , "SNake"                      , "S_NAKE",
    9  , "Snake"                     , "Snake"                        , "snake"                        , "snake"                      , "Snake"                      , "SNAKE",
    10 , "s_nake"                    , "s_nake"                       , "s_nake"                       , "sNake"                      , "SNake"                      , "S_NAKE",
    11 , "sn_ake"                    , "sn_ake"                       , "sn_ake"                       , "snAke"                      , "SnAke"                      , "SN_AKE",
    12 , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    13 , "SNaKE"                     , "S_Na_KE"                      , "s_na_ke"                      , "sNaKe"                      , "SNaKe"                      , "S_NA_KE",
    14 , "SNaKEr"                    , "S_Na_K_Er"                    , "s_na_k_er"                    , "sNaKEr"                     , "SNaKEr"                     , "S_NA_K_ER",
    15 , "s_na_k_er"                 , "s_na_k_er"                    , "s_na_k_er"                    , "sNaKEr"                     , "SNaKEr"                     , "S_NA_K_ER",
    16 , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    17 , "SNAKE SNAKE CASE"          , "SNAKE_SNAKE_CASE"             , "snake_snake_case"             , "snakeSnakeCase"             , "SnakeSnakeCase"             , "SNAKE_SNAKE_CASE",
    18 , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    19 , "snakeSnakECase"            , "snake_Snak_E_Case"            , "snake_snak_e_case"            , "snakeSnakECase"             , "SnakeSnakECase"             , "SNAKE_SNAK_E_CASE",
    20 , "SNAKE snakE_case"          , "SNAKE_snak_E_case"            , "snake_snak_e_case"            , "snakeSnakECase"             , "SnakeSnakECase"             , "SNAKE_SNAK_E_CASE",
    21 , "_"                         , ""                             , ""                             , ""                           , ""                           , "",
    22 , "ssRRss"                    , "ss_R_Rss"                     , "ss_r_rss"                     , "ssRRss"                     , "SsRRss"                     , "SS_R_RSS",
    23 , "ssRRRR"                    , "ss_RRRR"                      , "ss_rrrr"                      , "ssRrrr"                     , "SsRrrr"                     , "SS_RRRR",
    24 , "thisIsSomeCamelCase"       , "this_Is_Some_Camel_Case"      , "this_is_some_camel_case"      , "thisIsSomeCamelCase"        , "ThisIsSomeCamelCase"        , "THIS_IS_SOME_CAMEL_CASE",
    25 , "this.text"                 , "this.text"                    , "this.text"                    , "this.Text"                  , "This.Text"                  , "THIS.TEXT",
    26 , "next.text"                 , "next.text"                    , "next.text"                    , "next.Text"                  , "Next.Text"                  , "NEXT.TEXT",
    27 , "zip code"                  , "zip_code"                     , "zip_code"                     , "zipCode"                    , "ZipCode"                    , "ZIP_CODE",
    28 , "state"                     , "state"                        , "state"                        , "state"                      , "State"                      , "STATE",
    29 , "final count"               , "final_count"                  , "final_count"                  , "finalCount"                 , "FinalCount"                 , "FINAL_COUNT",
    30 , "BobDylanUSA"               , "Bob_Dylan_USA"                , "bob_dylan_usa"                , "bobDylanUsa"                , "BobDylanUsa"                , "BOB_DYLAN_USA",
    31 , "MikhailGorbachevUSSR"      , "Mikhail_Gorbachev_USSR"       , "mikhail_gorbachev_ussr"       , "mikhailGorbachevUssr"       , "MikhailGorbachevUssr"       , "MIKHAIL_GORBACHEV_USSR", 
    32 , "HelpfulStackOverflowPeople", "Helpful_Stack_Overflow_People", "helpful_stack_overflow_people", "helpfulStackOverflowPeople" , "HelpfulStackOverflowPeople" , "HELPFUL_STACK_OVERFLOW_PEOPLE", 
    33 , "IAmATallDrinkOfWater"      , "I_Am_A_Tall_Drink_Of_Water"   , "i_am_a_tall_drink_of_water"   , "iAmATallDrinkOfWater"       , "IAmATallDrinkOfWater"       , "I_AM_A_TALL_DRINK_OF_WATER",
    34 , "ICUDays"                   , "ICU_Days"                     , "icu_days"                     , "icuDays"                    , "IcuDays"                    , "ICU_DAYS",
    35 , "SexCode"                   , "Sex_Code"                     , "sex_code"                     , "sexCode"                    , "SexCode"                    , "SEX_CODE",
    36 , "MAX_of_MLD"                , "MAX_of_MLD"                   , "max_of_mld"                   , "maxOfMld"                   , "MaxOfMld"                   , "MAX_OF_MLD",
    37 , "Age.Group"                 , "Age.Group"                    , "age.group"                    , "age.Group"                  , "Age.Group"                  , "AGE.GROUP",
    38 , "ThisText"                  , "This_Text"                    , "this_text"                    , "thisText"                   , "ThisText"                   , "THIS_TEXT",
    39 , "NextText"                  , "Next_Text"                    , "next_text"                    , "nextText"                   , "NextText"                   , "NEXT_TEXT",
    40 , "test_123_ 1 1"             , "test_123_1_1"                 , "test_123_1_1"                 , "test123_1_1"                , "Test123_1_1"                , "TEST_123_1_1"
    )

# dat for arguments of to_any_case(). test non NULL arguments via dat. 
# test other three special case via specific examples
string <- c(NA, "_", "s_na_k_er", "SNAKE SNAKE CASE", "snakeSnakECase",
            "SNAKE snakE_case", "ssRRss", "ssRRRR", "thisIsSomeCamelCase",
            "this.text", "final count", "BobDylanUSA", "MikhailGorbachevUSSR",
            "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "ICUDays", "SexCode",
            "MAX_of_MLD", "Age.Group")
case <- c("parsed", "snake", "small_camel", "big_camel", "screaming_snake")
prefix <- c("", "start.")
postfix <- c("", ".end")
transliterations <- c(TRUE, FALSE)
  
dat <- expand.grid(string = string,
                     case = case,
                     postfix = postfix,
                     prefix = prefix,
                     transliterations = transliterations,
                     stringsAsFactors = FALSE)

# code to generate new results.
# purrrlyr::invoke_rows(snakecase::to_any_case, dat,
#                    preprocess = NULL,
#                    postprocess = NULL,
#                    .collate = "cols",
#                    .to = "output") %>% .$output %>% dput()

# Some Benchmarks:
# devtools::install_github("Tazinho/snakecase", force = TRUE)
# library(snakecase)
# 
# string_gen <- function(times){paste0("str", 1:times)}
# other_gen <- function(times){paste0("other", 1:times)}
# 
# str10 <- string_gen(10)
# str1000 <- string_gen(1000)
# oth10 <- other_gen(10)
# oth1000 <- other_gen(1000)
# 
# microbenchmark::microbenchmark(
#   to_any_case(string = str10, case = "snake", preprocess = oth10),
#   to_any_case(string = str1000, case = "snake", preprocess = oth1000)
# )
# 
# microbenchmark::microbenchmark(
#   to_any_case(string = str10, case = "snake", postprocess = oth10),
#   to_any_case(string = str1000, case = "snake", postprocess = oth1000)
# )
# 
# microbenchmark::microbenchmark(
#   to_any_case(string = str10, case = "snake",   prefix = oth10),
#   to_any_case(string = str1000, case = "snake", prefix = oth1000)
# )
# 
# microbenchmark::microbenchmark(
#   to_any_case(string = str10, case = "snake"  , postfix = oth10),
#   to_any_case(string = str1000, case = "snake", postfix = oth1000)
# )
# 
# microbenchmark::microbenchmark(
#   to_any_case(string = str10, case = "snake"  , protect = oth10),
#   to_any_case(string = str1000, case = "snake", protect = oth1000)
# )
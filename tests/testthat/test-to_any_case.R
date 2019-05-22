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
  
  expect_equal(to_any_case("R.Studio", case = "big_camel", sep_out = "-"),
               "R-Studio")
  
  expect_equal(to_any_case("HAMBURGcity", case = "parsed", parsing_option = 0),
               "HAMBURGcity")
  
  expect_equal(to_any_case(c("RSSfeedRSSfeed", "USPassport", "USpassport"), abbreviations = c("RSS", "US")),
               c("rss_feed_rss_feed", "us_passport", "us_passport"))
  
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "parsed"),
               "NBA_Game")
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "mixed"),
               "NBA_Game")
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "snake"),
               "nba_game")
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "screaming_snake"),
               "NBA_GAME")
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "internal_parsing"),
               "NBA_Game")
  expect_equal(to_any_case("NBAGame", abbreviations = "NBA", case = "upper_camel"),
               "NBAGame")
  expect_equal(to_any_case("nba_game", abbreviations = "NBA", case = "lower_camel"),
               "nbaGame")
  expect_equal(to_any_case("NBA_game", abbreviations = "NBA", case = "upper_camel"),
               "NBAGame")
  expect_equal(to_any_case("nba_game", abbreviations = "NBA", case = "upper_camel"),
               "NBAGame")
  expect_equal(to_any_case("NBA_game_NBA", abbreviations = "NBA", case = "lower_camel"),
               "nbaGameNBA")
  expect_equal(to_any_case("NBA_game_NBA", abbreviations = "NBA", case = "lower_upper"),
               "nbaGAMEnba")
  expect_equal(to_any_case("NBA_game", abbreviations = "NBA", case = "mixed"),
               "NBA_game")
  expect_equal(to_any_case("NBA_game_NBA", abbreviations = "NBA", case = "mixed"),
               "NBA_game_NBA")
  expect_equal(to_snake_case(c("NBAGame", "NBAgame"), abbreviations = "NBA"),
               c("nba_game", "nba_game"))
  expect_equal(to_upper_camel_case(c("nba_game", "nba_game"), abbreviations = "NBA"),
               c("NBAGame", "NBAGame"))
  }
)

test_that("numerals_tight",
          {
            expect_equal(to_any_case("bla_la_123_123_1_bla", numerals = "tight"),
                         "bla_la123_123_1bla")
          })

test_that("attributes", {
  expect_equal(
    {strings <- c("this Is a Strange_string", "AND THIS ANOTHER_One");
    names(strings) <- c("String A", "String B");
    attr(strings, "test.attr") <- "test";
    strings},
    structure(c(`String A` = "this Is a Strange_string", `String B` = "AND THIS ANOTHER_One"),
              test.attr = "test"))
    }
  )

test_that("numerals", {
  expect_equal(to_any_case("123bla123bla_434bla"),
               "123_bla_123_bla_434_bla")
  
  expect_equal(to_any_case("123bla123bla_434bla", 
                           numerals = "asis"),
               "123bla123bla_434bla")
  
  expect_equal(to_any_case("123bla123bla_434bla",
                           numerals = "left"),
               "123_bla123_bla434_bla")

  expect_equal(to_any_case("123bla123bla_434bla", 
                           numerals = "right"),
               "123bla_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "middle"),
               "123_bla_123_123_bla_434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "asis"),
               "123bla123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "left"),
               "123_bla123_123_bla434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla",
                           numerals = "right"),
               "123bla_123_123bla_434bla")

  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "right"), 
               "123bla_123_123bla_434bla")

  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "right"),
               "123bla_123_123bla_434bla")
  
  expect_equal(to_upper_camel_case("123bla123_123bla_434bla"),
               "123Bla123_123Bla434Bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", case = "upper_camel", numerals = "middle"),
    "123Bla123_123Bla434Bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", case = "upper_camel", numerals = "asis"), "123Bla123_123Bla434Bla")

  expect_equal(to_any_case("123bla123_123bla_434bla", case = "upper_camel", numerals = "left"), 
               "123Bla123_123Bla434Bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", case = "upper_camel", numerals = "right"),
               "123Bla123_123Bla434Bla")

  expect_equal(to_any_case("123bla123_123bla_434bla", case = "parsed", numerals = "middle"),
               "123_bla_123_123_bla_434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", case = "parsed", numerals = "asis"),
               "123bla123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", case = "parsed", numerals = "left"),
               "123_bla123_123_bla434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla",
                           case = "parsed",
                           numerals = "right"),
    "123bla_123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", 
                           case = "none",
                           numerals = "middle"),
               "123bla123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", 
                           case = "none", 
                           numerals = "asis"),
               "123bla123_123bla_434bla")

  expect_equal(to_any_case("123bla123_123bla_434bla",
                           case = "none",
                           numerals = "left"),
               "123bla123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", 
                           case = "none",
                           numerals = "right"),
               "123bla123_123bla_434bla")

  expect_equal(to_any_case("123bla123_123bla_434bla", 
                           numerals = "middle"),
               "123_bla_123_123_bla_434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla", numerals = "asis"),
               "123bla123_123bla_434bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla",
                           numerals = "left"),
               "123_bla123_123_bla434_bla")
  
  expect_equal(to_any_case("123bla123_123bla_434bla",
                           numerals = "right"),
               "123bla_123_123bla_434bla")
  
  expect_equal(to_any_case("species42value 23month",
                           numerals = "asis"),
               "species42value_23month")
  
  expect_equal(to_any_case(c("HHcity", "IDtable1", "KEYtable2", "newUSelections"),
                           parsing_option = 2,
                           numerals = "middle"),
               c("hh_city", "id_table_1", "key_table_2", "new_us_elections"))
  
  expect_equal(to_any_case(c("HHcity", "IDtable1", "KEYtable2", "newUSelections"),
                           parsing_option = 2, 
                           numerals = "asis"),
               c("hh_city","id_table1", "key_table2", "new_us_elections"))
  
  expect_equal(to_any_case(c("HHcity", "IDtable1", "KEYtable2", "newUSelections"), parsing_option = 2, numerals = "left"),
               c("hh_city", "id_table1", "key_table2","new_us_elections"))

  expect_equal(to_any_case(c("HHcity", "IDtable1", "KEYtable2", "newUSelections"),
                           parsing_option = 2,
                           numerals = "right"),
               c("hh_city", "id_table_1", "key_table_2",
                 "new_us_elections"))
})

test_that("preserve-names-attribute", {
  
  labs <- c(a = "abcDEF", b = "bbccEE", c = "TeESt it")
  
  expect_equal(
    to_any_case(labs, case = "snake"),
    structure(c("abc_def", "bbcc_ee", "te_e_st_it"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "upper_camel"),
    structure(c("AbcDef", "BbccEe", "TeEStIt"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "lower_camel"),
    structure(c("abcDef", "bbccEe", "teEStIt"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "parsed"),
    structure(c("abc_DEF", "bbcc_EE", "Te_E_St_it"), .Names = c("a", "b", "c"))
  )
  
  expect_equal(
    to_any_case(labs, case = "mixed"),
    structure(c("abc_Def", "bbcc_Ee", "Te_E_St_it"), .Names = c("a", "b", "c"))
  )
  
  expect_equal(
    to_any_case(labs, case = "none", sep_in = NULL), 
    structure(c("abcDEF", "bbccEE", "TeESt it"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "all_caps"),
    structure(c("ABC_DEF", "BBCC_EE", "TE_E_ST_IT"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "upper_lower"),
    structure(c("ABCdef", "BBCCee", "TEeSTit"), .Names = c("a", "b", "c"))
    )
  
  expect_equal(
    to_any_case(labs, case = "lower_upper"),
    structure(c("abcDEF", "bbccEE", "teEstIT"), .Names = c("a", "b", "c"))
    )
})

test_that("uniqe_sep", {
  expect_equal(
    to_any_case(c("bla", "bla"), unique_sep = "_"),
    c("bla",   "bla_1")
  )
  
  expect_equal(
    to_any_case(c("bla", "bla"), unique_sep = NULL),
    c("bla", "bla")
  )
})

test_that("sentence_case", {
  expect_equal(
  to_sentence_case("this_is_a_sentence", sep_out = " ", postfix = "."),
  "This is a sentence.")
})

test_that("janitor-pkg-tests",{
  skip_if_not( l10n_info()$`UTF-8`)
  
  clean_names3 <- function(old_names, case = "snake"){
    new_names <- gsub("'", "", old_names) # remove quotation marks
    new_names <- gsub("\"", "", new_names) # remove quotation marks
    new_names <- gsub("%", ".percent_", new_names)
    new_names <- gsub("#", ".number_", new_names)
    new_names <- gsub("^[[:space:][:punct:]]+", "", new_names)
    new_names <- make.names(new_names)
    new_names <- to_any_case(new_names, case = case, sep_in = "\\.", 
                  transliterations = c("Latin-ASCII"), parsing_option = 1, numerals = "asis")
    # Handle duplicated names - they mess up dplyr pipelines
    # This appends the column number to repeated instances of duplicate variable names
    dupe_count <- vapply(1:length(new_names), function(i) { 
      sum(new_names[i] == new_names[1:i]) }, integer(1))
    
    new_names[dupe_count > 1] <- paste(new_names[dupe_count > 1],
                                       dupe_count[dupe_count > 1],
                                       sep = "_")
    new_names
  }
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                 "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                 "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143")),
               c("sp_ace", "repeated", "a", "percent", "x", "x_2", "d_9", "repeated_2", 
                 "cant", "hi_there", "leading_spaces", "x_3", "acao", "faroe", 
                 "r_studio_v_1_0_143"))
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "parsed"),
               c("sp_ace", "repeated", "a", "percent", "X", "X_2", "d_9", "REPEATED", 
                 "cant", "hi_there", "leading_spaces", "X_3", "acao", "faroe", 
                 "r_studio_v_1_0_143"))
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "screaming_snake"),
               c("SP_ACE", "REPEATED", "A", "PERCENT", "X", "X_2", "D_9", "REPEATED_2", 
                 "CANT", "HI_THERE", "LEADING_SPACES", "X_3", "ACAO", "FAROE", 
                 "R_STUDIO_V_1_0_143")
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "small_camel"),
               c("spAce", "repeated", "a", "percent", "x", "x_2", "d9", "repeated_2", 
                 "cant", "hiThere", "leadingSpaces", "x_3", "acao", "faroe", "rStudioV1_0_143"
               )
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "big_camel"),
               c("SpAce", "Repeated", "A", "Percent", "X", "X_2", "D9", "Repeated_2", 
                 "Cant", "HiThere", "LeadingSpaces", "X_3", "Acao", "Faroe", "RStudioV1_0_143"
               )
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "lower_upper"),
               c("spACE", "repeated", "a", "percent", "x", "x_2", "d9", "repeated_2", 
                 "cant", "hiTHERE", "leadingSPACES", "x_3", "acao", "faroe", "rSTUDIOv1_0_143"
               )
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "upper_lower"),
               c("SPace", "REPEATED", "A", "PERCENT", "X", "X_2", "D9", "REPEATED_2", 
                 "CANT", "HIthere", "LEADINGspaces", "X_3", "ACAO", "FAROE", "RstudioV1_0_143"
               )
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%", "#",
                              "!", "d(!)9", "REPEATED", "can\"'t", "hi_`there`",
                              "  leading spaces", "\u20AC", "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "mixed"),
               c("sp_ace", "repeated", "a", "percent", "X", "X_2", "d_9", "Repeated", 
                 "cant", "hi_there", "leading_spaces", "X_3", "acao", "faroe", 
                 "r_studio_v_1_0_143")
  )
  
  expect_equal(clean_names3(c("sp ace", "repeated", "a**#@", "%",
                              "#", "!", "d(!)9", "REPEATED",
                              "can\"'t", "hi_`there`", "  leading spaces", "\u20AC",
                              "a\u00E7\u00E3o", "far\u0153", "r.st\u00FCdio:v.1.0.143"),
                            case = "none"),
               c("sp_ace", "repeated", "a", "percent",
                 "X", "X_2", "d_9", "REPEATED",
                 "cant", "hi_there", "leading_spaces", "X_3", 
                 "acao", "faroe", "r_studio_v_1_0_143")
  )
})

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
# test_that("deprecated",
#           expect_warning(to_any_case("bla", protect = "_"),
#                          "argument protect is deprecated; If you really need this argument, pls submit an issue on https://github.com/Tazinho/snakecase")
#           )

test_that("transliterations", {
  
  skip_if_not( l10n_info()$`UTF-8`)
  
  expect_equal(to_any_case("Älterer Herr", transliterations = c("german", "Herr" = "Mann")), "aelterer_mann")
  
  expect_equal(
    to_any_case("Älterer Herr", transliterations = c( "Herr" = "Mann", "german")),
    "aelterer_mann")
})

test_that("transliterations_error", 
          expect_error(to_any_case("bla", transliterations = "bla"),
                       "Input to `transliterations` must be `NULL`, a string containing elements from the internal lookup dictionaries or from `stringi::stri_trans_list()` or a named vector.",
                       fixed = TRUE))

test_that("empty_fill",
          expect_equal(to_any_case("", empty_fill = "bla"),
          "bla"))

test_that("sentence",
          expect_equal(to_any_case("bla bla_bal", case = "sentence"),
                       "Bla bla bal"))
  
test_that("flip and swap", {
          expect_equal(to_any_case("rSTUDIO", case = "flip"), "Rstudio")
          
          expect_equal(to_any_case("rSTUDIO", case = "swap"), "Rstudio")
})

test_that("complex strings", {
  
  skip_if_not( l10n_info()$`UTF-8`)
  
  strings2 <- c("this - Is_-: a Strange_string", "\u00C4ND THIS ANOTHER_One")
  
  expect_equal(to_any_case(strings2, case = "snake", sep_in = "-|\\:"),
               c("this_is_a_strange_string", "\u00E4nd_this_another_one"))
  
  expect_equal(to_any_case("MERKWUERDIGER-VariablenNAME mit.VIELENMustern_version: 3.7.4",
                           case = "snake",
                           sep_in = "-|:|(?<!\\d)\\.",
                           sep_out = "."),
               "merkwuerdiger.variablen.name.mit.vielen.mustern.version.3.7.4")
  
  expect_equal(to_any_case("R.Studio", case = "big_camel"),
               c("RStudio"))
  
  expect_equal(to_any_case("R.Studio: v 1.0.143", case = "big_camel", sep_in = "\\.", sep_out = "_"),
               "R_Studio:V_1_0_143")
  
  expect_equal(to_any_case("R.aStudio", case = "snake", sep_out = "-"), "r-a-studio")
  expect_equal(to_any_case("R.aStudio", case = "snake", sep_out = "-"), "r-a-studio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", sep_out = "-"), "R-A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", sep_out = "-"), "R-A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", sep_out = "-"), "r-A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", sep_out = "-"), "r-A-Studio")
  expect_equal(to_any_case("r.aStudio", sep_out = "-", case = "big_camel"), "R-A-Studio")
  
  expect_equal(to_any_case("rStudio", case = "none", prefix = "rrr."),
               "rrr.rStudio")
  
  expect_equal(to_any_case("Rstudio_STudio_sssTTT", case = "mixed"),
               "Rstudio_S_Tudio_sss_Ttt")
  expect_equal(to_any_case("Rstudio_STudio_sssTTT", case = "mixed", parsing_option = 2),
               "Rstudio_St_udio_sss_Ttt")
  
  expect_equal(to_any_case(names(iris), case = "lower_upper", sep_in = "\\.", sep_out = "-"),
               c("sepal-LENGTH", "sepal-WIDTH", "petal-LENGTH", "petal-WIDTH", "species"))
  
  expect_equal(to_any_case("R.aStudio", case = "lower_upper"),
               "rAstudio")
  expect_equal(to_any_case("R.aStudio", case = "upper_lower"),
               "RaSTUDIO")
  
  expect_equal(to_any_case("R.aStudio", case = "lower_upper"),
               "rAstudio")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", sep_out = "-"),
               "r-A-studio")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", sep_out = "-"),
               "r-A-studio")
  
  expect_equal(to_any_case("rstudio", case = "all_caps"),
               "RSTUDIO")
  expect_equal(to_any_case("rstudio", case = "upper_camel"),
               "Rstudio")
  expect_equal(to_any_case("rstudio", case = "lower_camel"),
               "rstudio")
  expect_equal(to_any_case("bla rstudio", case = "lower_camel"),
               "blaRstudio")
  
  expect_equal(to_any_case("R.aStudio", case = "parsed", sep_out = "-"),
               "R-a-Studio")
  expect_equal(to_any_case("R.aStudio", case = "small_camel", sep_out = "-"),
               "r-A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "big_camel", sep_out = "-"),
               "R-A-Studio")
  expect_equal(to_any_case("R.aStudio", case = "screaming_snake", sep_out = "-"),
               "R-A-STUDIO")
  expect_equal(to_any_case("R.aStudio", case = "lower_upper", sep_out = "-"),
               "r-A-studio")
  expect_equal(to_any_case("R.aStudio", case = "upper_lower", sep_out = "-"),
               "R-a-STUDIO")
  expect_equal(to_any_case("R.aStudio", case = "none", sep_out = "-"),
               "R-aStudio")
  expect_equal(to_any_case("R.aStudio", case = "mixed", sep_out = "-"),
               "R-a-Studio")
  
  expect_equal(to_any_case(character(0), sep_out = "c"), character())
  
  expect_equal(to_any_case("fdf 1 2", case = "big_camel"),
               "Fdf1_2")
  
  expect_equal(to_any_case("kleines Ha.schen", "screaming_snake"),
               "KLEINES_HA_SCHEN")
  
  expect_equal(to_any_case("kleines Ha.schen", "screaming_snake"),
               "KLEINES_HA_SCHEN")
  
  expect_equal(to_any_case(c("R.aStudio", NA, NA, NA, NA), case = "upper_lower"),
               c("RaSTUDIO", NA, NA, NA, NA))
  
  expect_equal(to_any_case("ac\u00C4o", transliterations = "Latin-ASCII"),
               "ac_ao")
  
  expect_equal(to_any_case("ac\u00C4o", transliterations = c("german", "Latin-ASCII")),
               "ac_aeo")
  #
  expect_equal(to_any_case("\u00C6", transliterations = c("danish", "Latin-ASCII")),
               "ae")
  expect_equal(to_any_case("\u00E6", transliterations = c("danish", "Latin-ASCII")),
               "ae")
  expect_equal(to_any_case("\u00D8", transliterations = c("danish", "Latin-ASCII")),
               "oe")
  expect_equal(to_any_case("\u00F8", transliterations = c("danish", "Latin-ASCII")),
               "oe")
  expect_equal(to_any_case("\u00C5", transliterations = c("danish", "Latin-ASCII")),
               "aa")
  expect_equal(to_any_case("\u00E5", transliterations = c("danish", "Latin-ASCII")),
               "aa")
  
  expect_equal(to_any_case("\u00C6", transliterations = c("finnish", "Latin-ASCII")),
               "a")
  expect_equal(to_any_case("\u00E6", transliterations = c("finnish", "Latin-ASCII")),
               "a")
  expect_equal(to_any_case("\u00D8", transliterations = c("finnish", "Latin-ASCII")),
               "o")
  expect_equal(to_any_case("\u00F8", transliterations = c("finnish", "Latin-ASCII")),
               "o")
  
  expect_equal(to_any_case("\u00C6", transliterations = c("swedish")),
               "a")
  expect_equal(to_any_case("\u00E6", transliterations = c("swedish")),
               "a")
  expect_equal(to_any_case("\u00D8", transliterations = c("swedish")),
               "o")
  expect_equal(to_any_case("\u00F8", transliterations = c("swedish")),
               "o")
  expect_equal(to_any_case("\u00C5", transliterations = c("swedish")),
               "a")
  expect_equal(to_any_case("\u00E5", transliterations = c("swedish")),
               "a")
  
  expect_equal(to_any_case("\u00E6", transliterations = "Latin-ASCII"),
                "ae")
  
  expect_equal(to_any_case("bla.bla", case = "none", sep_in = "\\."),
               "bla_bla")
  
  expect_equal(to_any_case("blaUSABlaGERBlaZDFBla", abbreviations = c("USA", "GER", "ZDF", "BLA"), case = "mixed"),
               "BLA_USA_BLA_GER_BLA_ZDF_BLA")
  
  expect_equal(to_any_case("someUSPeople", abbreviations = "US", case = "mixed", sep_out = " "),
               "some US People")
  
  # expect_equal(to_any_case(c(NA, NA, NA), "lower_upper"),
  #              rep(NA_character_, 3))
  # 
  # expect_equal(to_any_case(c(NA, NA, NA), "upper_lower"),
  #              rep(NA_character_, 3))
  expect_equal(snakecase::to_any_case("blaBla.bla", case = "big_camel", parsing_option = 3),
               "BlaBlaBla")
  
  expect_equal(to_any_case("bla-bla", case = "upper_camel", parsing_option = 3),
               "BlaBla")
  expect_equal(to_any_case("bla.bla", case = "upper_camel", parsing_option = 3),
               "BlaBla")
  expect_equal(to_any_case("bla.bla", case = "upper_camel"),
               "BlaBla")
  expect_equal(to_any_case("a_b_c_d", case = "upper_camel"),
               "ABCD")
  
  expect_equal(to_any_case("some11 21 31numbers_11 21 32_With11 11_diffs11 22 d", case = "upper_camel"),
               "Some11_21_31Numbers11_21_32With11_11Diffs11_22D")
  expect_equal(to_any_case("some11 21 31numbers_11 21 32_With11 11_diffs11 22 d", case = "lower_camel"),
               "some11_21_31Numbers11_21_32With11_11Diffs11_22D")
  expect_equal(to_any_case("some11 21 31numbers_11 21 32_With11 11_diffs11 22 d", case = "upper_lower"),
               "SOME11_21_31numbers11_21_32WITH11_11diffs11_22D")
  expect_equal(to_any_case("some11 21 31numbers_11 21 32_With11 11_diffs11 22 d", case = "lower_upper"),
               "some11_21_31NUMBERS11_21_32with11_11DIFFS11_22d")
  
})


test_that("stackoverflow answers", {
  expect_equal(to_any_case(c("ThisText", "NextText"), case = "snake", sep_out = "."),
               c("this.text", "next.text"))
  
  expect_equal(to_any_case(c("BobDylanUSA",
                             "MikhailGorbachevUSSR",
                             "HelpfulStackOverflowPeople",
                             "IAmATallDrinkOfWater"),
                           case = "parsed",
                           sep_out = " "),
               c("Bob Dylan USA", "Mikhail Gorbachev USSR",
                 "Helpful Stack Overflow People", "I Am A Tall Drink Of Water"))
  
  expect_equal(to_any_case(c("ICUDays","SexCode","MAX_of_MLD","Age.Group"),
                           case = "snake",
                           sep_in = "\\."),
               c("icu_days", "sex_code", "max_of_mld", "age_group")) 

  expect_equal(to_any_case(c("ICUDays","SexCode","MAX_of_MLD","Age.Group"),
                           case = "small_camel",
                           sep_in = "\\."),
               c("icuDays", "sexCode", "maxOfMld", "ageGroup")) 
  
  expect_equal(unlist(strsplit(snakecase::to_parsed_case("thisIsSomeCamelCase"), "_")),
               c("this", "Is", "Some", "Camel", "Case"))
  
  expect_equal(to_any_case(c("zip code", "state", "final count"),
                           case = "big_camel",
                           sep_out = " "),
               c("Zip Code", "State", "Final Count"))
  
  expect_equal(to_any_case(c("this.text", "next.text"),
                           case = "big_camel", 
                           sep_in = "\\."),
               c("ThisText", "NextText"))
})

test_that("parsing cases", {
  expect_equal(to_any_case("RRRStudio", case = "parsed"), 
               "RRR_Studio")
  
  expect_equal(to_any_case("RRRStudio", case = "parsed", parsing_option = 1), 
               "RRR_Studio")

  expect_equal(to_any_case("RRRStudio", case = "parsed", parsing_option = 2), 
               "RRRS_tudio")
  
  expect_equal(check_design_rule("RRRStudio", parsing_option = 1),
               TRUE)
  
  expect_equal(check_design_rule("RRRStudio", parsing_option = 2),
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
                     sep_in = NULL,
                     sep_out = NULL,
                     .collate = "cols",
                     .to = "output")$output, #%>% dput
               c(NA, "", "s_na_k_er", "SNAKE_SNAKE_CASE", "snake_Snak_E_Case", 
                 "SNAKE_snak_E_case", "ss_R_Rss", "ss_RRRR", "this_Is_Some_Camel_Case", 
                 "this.text", "final_count", "Bob_Dylan_USA", "Mikhail_Gorbachev_USSR", 
                 "Helpful_Stack_Overflow_People", "Im_A_Tall_Drink_Of_Water", 
                 "ICU_Days", "Sex_Code", "MAX_of_MLD", "Age.Group", NA, "", 
                 "s_na_k_er", "snake_snake_case", "snake_snak_e_case", "snake_snak_e_case", 
                 "ss_r_rss", "ss_rrrr", "this_is_some_camel_case", "this.text", 
                 "final_count", "bob_dylan_usa", "mikhail_gorbachev_ussr", "helpful_stack_overflow_people", 
                 "im_a_tall_drink_of_water", "icu_days", "sex_code", "max_of_mld", 
                 "age.group", NA, "", "sNaKEr", "snakeSnakeCase", "snakeSnakECase", 
                 "snakeSnakECase", "ssRRss", "ssRrrr", "thisIsSomeCamelCase", 
                 "this.Text", "finalCount", "bobDylanUsa", "mikhailGorbachevUssr", 
                 "helpfulStackOverflowPeople", "imATallDrinkOfWater", "icuDays", 
                 "sexCode", "maxOfMld", "age.Group", NA, "", "SNaKEr", "SnakeSnakeCase", 
                 "SnakeSnakECase", "SnakeSnakECase", "SsRRss", "SsRrrr", "ThisIsSomeCamelCase", 
                 "This.Text", "FinalCount", "BobDylanUsa", "MikhailGorbachevUssr", 
                 "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "IcuDays", 
                 "SexCode", "MaxOfMld", "Age.Group", NA, "", "S_NA_K_ER", "SNAKE_SNAKE_CASE", 
                 "SNAKE_SNAK_E_CASE", "SNAKE_SNAK_E_CASE", "SS_R_RSS", "SS_RRRR", 
                 "THIS_IS_SOME_CAMEL_CASE", "THIS.TEXT", "FINAL_COUNT", "BOB_DYLAN_USA", 
                 "MIKHAIL_GORBACHEV_USSR", "HELPFUL_STACK_OVERFLOW_PEOPLE", "IM_A_TALL_DRINK_OF_WATER", 
                 "ICU_DAYS", "SEX_CODE", "MAX_OF_MLD", "AGE.GROUP", NA, ".end", 
                 "s_na_k_er.end", "SNAKE_SNAKE_CASE.end", "snake_Snak_E_Case.end", 
                 "SNAKE_snak_E_case.end", "ss_R_Rss.end", "ss_RRRR.end", "this_Is_Some_Camel_Case.end", 
                 "this.text.end", "final_count.end", "Bob_Dylan_USA.end", "Mikhail_Gorbachev_USSR.end", 
                 "Helpful_Stack_Overflow_People.end", "Im_A_Tall_Drink_Of_Water.end", 
                 "ICU_Days.end", "Sex_Code.end", "MAX_of_MLD.end", "Age.Group.end", 
                 NA, ".end", "s_na_k_er.end", "snake_snake_case.end", "snake_snak_e_case.end", 
                 "snake_snak_e_case.end", "ss_r_rss.end", "ss_rrrr.end", "this_is_some_camel_case.end", 
                 "this.text.end", "final_count.end", "bob_dylan_usa.end", "mikhail_gorbachev_ussr.end", 
                 "helpful_stack_overflow_people.end", "im_a_tall_drink_of_water.end", 
                 "icu_days.end", "sex_code.end", "max_of_mld.end", "age.group.end", 
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
                 "THIS.TEXT.end", "FINAL_COUNT.end", "BOB_DYLAN_USA.end", "MIKHAIL_GORBACHEV_USSR.end", 
                 "HELPFUL_STACK_OVERFLOW_PEOPLE.end", "IM_A_TALL_DRINK_OF_WATER.end", 
                 "ICU_DAYS.end", "SEX_CODE.end", "MAX_OF_MLD.end", "AGE.GROUP.end", 
                 NA, "start.", "start.s_na_k_er", "start.SNAKE_SNAKE_CASE", "start.snake_Snak_E_Case", 
                 "start.SNAKE_snak_E_case", "start.ss_R_Rss", "start.ss_RRRR", 
                 "start.this_Is_Some_Camel_Case", "start.this.text", "start.final_count", 
                 "start.Bob_Dylan_USA", "start.Mikhail_Gorbachev_USSR", "start.Helpful_Stack_Overflow_People", 
                 "start.Im_A_Tall_Drink_Of_Water", "start.ICU_Days", "start.Sex_Code", 
                 "start.MAX_of_MLD", "start.Age.Group", NA, "start.", "start.s_na_k_er", 
                 "start.snake_snake_case", "start.snake_snak_e_case", "start.snake_snak_e_case", 
                 "start.ss_r_rss", "start.ss_rrrr", "start.this_is_some_camel_case", 
                 "start.this.text", "start.final_count", "start.bob_dylan_usa", 
                 "start.mikhail_gorbachev_ussr", "start.helpful_stack_overflow_people", 
                 "start.im_a_tall_drink_of_water", "start.icu_days", "start.sex_code", 
                 "start.max_of_mld", "start.age.group", NA, "start.", "start.sNaKEr", 
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
                 "start.THIS_IS_SOME_CAMEL_CASE", "start.THIS.TEXT", "start.FINAL_COUNT", 
                 "start.BOB_DYLAN_USA", "start.MIKHAIL_GORBACHEV_USSR", "start.HELPFUL_STACK_OVERFLOW_PEOPLE", 
                 "start.IM_A_TALL_DRINK_OF_WATER", "start.ICU_DAYS", "start.SEX_CODE", 
                 "start.MAX_OF_MLD", "start.AGE.GROUP", NA, "start..end", "start.s_na_k_er.end", 
                 "start.SNAKE_SNAKE_CASE.end", "start.snake_Snak_E_Case.end", 
                 "start.SNAKE_snak_E_case.end", "start.ss_R_Rss.end", "start.ss_RRRR.end", 
                 "start.this_Is_Some_Camel_Case.end", "start.this.text.end", 
                 "start.final_count.end", "start.Bob_Dylan_USA.end", "start.Mikhail_Gorbachev_USSR.end", 
                 "start.Helpful_Stack_Overflow_People.end", "start.Im_A_Tall_Drink_Of_Water.end", 
                 "start.ICU_Days.end", "start.Sex_Code.end", "start.MAX_of_MLD.end", 
                 "start.Age.Group.end", NA, "start..end", "start.s_na_k_er.end", 
                 "start.snake_snake_case.end", "start.snake_snak_e_case.end", 
                 "start.snake_snak_e_case.end", "start.ss_r_rss.end", "start.ss_rrrr.end", 
                 "start.this_is_some_camel_case.end", "start.this.text.end", 
                 "start.final_count.end", "start.bob_dylan_usa.end", "start.mikhail_gorbachev_ussr.end", 
                 "start.helpful_stack_overflow_people.end", "start.im_a_tall_drink_of_water.end", 
                 "start.icu_days.end", "start.sex_code.end", "start.max_of_mld.end", 
                 "start.age.group.end", NA, "start..end", "start.sNaKEr.end", 
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
                 "start.THIS_IS_SOME_CAMEL_CASE.end", "start.THIS.TEXT.end", 
                 "start.FINAL_COUNT.end", "start.BOB_DYLAN_USA.end", "start.MIKHAIL_GORBACHEV_USSR.end", 
                 "start.HELPFUL_STACK_OVERFLOW_PEOPLE.end", "start.IM_A_TALL_DRINK_OF_WATER.end", 
                 "start.ICU_DAYS.end", "start.SEX_CODE.end", "start.MAX_OF_MLD.end", 
                 "start.AGE.GROUP.end", NA, "", "s_na_k_er", "SNAKE_SNAKE_CASE", 
                 "snake_Snak_E_Case", "SNAKE_snak_E_case", "ss_R_Rss", "ss_RRRR", 
                 "this_Is_Some_Camel_Case", "this.text", "final_count", "Bob_Dylan_USA", 
                 "Mikhail_Gorbachev_USSR", "Helpful_Stack_Overflow_People", "Im_A_Tall_Drink_Of_Water", 
                 "ICU_Days", "Sex_Code", "MAX_of_MLD", "Age.Group", NA, "", 
                 "s_na_k_er", "snake_snake_case", "snake_snak_e_case", "snake_snak_e_case", 
                 "ss_r_rss", "ss_rrrr", "this_is_some_camel_case", "this.text", 
                 "final_count", "bob_dylan_usa", "mikhail_gorbachev_ussr", "helpful_stack_overflow_people", 
                 "im_a_tall_drink_of_water", "icu_days", "sex_code", "max_of_mld", 
                 "age.group", NA, "", "sNaKEr", "snakeSnakeCase", "snakeSnakECase", 
                 "snakeSnakECase", "ssRRss", "ssRrrr", "thisIsSomeCamelCase", 
                 "this.Text", "finalCount", "bobDylanUsa", "mikhailGorbachevUssr", 
                 "helpfulStackOverflowPeople", "imATallDrinkOfWater", "icuDays", 
                 "sexCode", "maxOfMld", "age.Group", NA, "", "SNaKEr", "SnakeSnakeCase", 
                 "SnakeSnakECase", "SnakeSnakECase", "SsRRss", "SsRrrr", "ThisIsSomeCamelCase", 
                 "This.Text", "FinalCount", "BobDylanUsa", "MikhailGorbachevUssr", 
                 "HelpfulStackOverflowPeople", "ImATallDrinkOfWater", "IcuDays", 
                 "SexCode", "MaxOfMld", "Age.Group", NA, "", "S_NA_K_ER", "SNAKE_SNAKE_CASE", 
                 "SNAKE_SNAK_E_CASE", "SNAKE_SNAK_E_CASE", "SS_R_RSS", "SS_RRRR", 
                 "THIS_IS_SOME_CAMEL_CASE", "THIS.TEXT", "FINAL_COUNT", "BOB_DYLAN_USA", 
                 "MIKHAIL_GORBACHEV_USSR", "HELPFUL_STACK_OVERFLOW_PEOPLE", "IM_A_TALL_DRINK_OF_WATER", 
                 "ICU_DAYS", "SEX_CODE", "MAX_OF_MLD", "AGE.GROUP", NA, ".end", 
                 "s_na_k_er.end", "SNAKE_SNAKE_CASE.end", "snake_Snak_E_Case.end", 
                 "SNAKE_snak_E_case.end", "ss_R_Rss.end", "ss_RRRR.end", "this_Is_Some_Camel_Case.end", 
                 "this.text.end", "final_count.end", "Bob_Dylan_USA.end", "Mikhail_Gorbachev_USSR.end", 
                 "Helpful_Stack_Overflow_People.end", "Im_A_Tall_Drink_Of_Water.end", 
                 "ICU_Days.end", "Sex_Code.end", "MAX_of_MLD.end", "Age.Group.end", 
                 NA, ".end", "s_na_k_er.end", "snake_snake_case.end", "snake_snak_e_case.end", 
                 "snake_snak_e_case.end", "ss_r_rss.end", "ss_rrrr.end", "this_is_some_camel_case.end", 
                 "this.text.end", "final_count.end", "bob_dylan_usa.end", "mikhail_gorbachev_ussr.end", 
                 "helpful_stack_overflow_people.end", "im_a_tall_drink_of_water.end", 
                 "icu_days.end", "sex_code.end", "max_of_mld.end", "age.group.end", 
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
                 "THIS.TEXT.end", "FINAL_COUNT.end", "BOB_DYLAN_USA.end", "MIKHAIL_GORBACHEV_USSR.end", 
                 "HELPFUL_STACK_OVERFLOW_PEOPLE.end", "IM_A_TALL_DRINK_OF_WATER.end", 
                 "ICU_DAYS.end", "SEX_CODE.end", "MAX_OF_MLD.end", "AGE.GROUP.end", 
                 NA, "start.", "start.s_na_k_er", "start.SNAKE_SNAKE_CASE", "start.snake_Snak_E_Case", 
                 "start.SNAKE_snak_E_case", "start.ss_R_Rss", "start.ss_RRRR", 
                 "start.this_Is_Some_Camel_Case", "start.this.text", "start.final_count", 
                 "start.Bob_Dylan_USA", "start.Mikhail_Gorbachev_USSR", "start.Helpful_Stack_Overflow_People", 
                 "start.Im_A_Tall_Drink_Of_Water", "start.ICU_Days", "start.Sex_Code", 
                 "start.MAX_of_MLD", "start.Age.Group", NA, "start.", "start.s_na_k_er", 
                 "start.snake_snake_case", "start.snake_snak_e_case", "start.snake_snak_e_case", 
                 "start.ss_r_rss", "start.ss_rrrr", "start.this_is_some_camel_case", 
                 "start.this.text", "start.final_count", "start.bob_dylan_usa", 
                 "start.mikhail_gorbachev_ussr", "start.helpful_stack_overflow_people", 
                 "start.im_a_tall_drink_of_water", "start.icu_days", "start.sex_code", 
                 "start.max_of_mld", "start.age.group", NA, "start.", "start.sNaKEr", 
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
                 "start.THIS_IS_SOME_CAMEL_CASE", "start.THIS.TEXT", "start.FINAL_COUNT", 
                 "start.BOB_DYLAN_USA", "start.MIKHAIL_GORBACHEV_USSR", "start.HELPFUL_STACK_OVERFLOW_PEOPLE", 
                 "start.IM_A_TALL_DRINK_OF_WATER", "start.ICU_DAYS", "start.SEX_CODE", 
                 "start.MAX_OF_MLD", "start.AGE.GROUP", NA, "start..end", "start.s_na_k_er.end", 
                 "start.SNAKE_SNAKE_CASE.end", "start.snake_Snak_E_Case.end", 
                 "start.SNAKE_snak_E_case.end", "start.ss_R_Rss.end", "start.ss_RRRR.end", 
                 "start.this_Is_Some_Camel_Case.end", "start.this.text.end", 
                 "start.final_count.end", "start.Bob_Dylan_USA.end", "start.Mikhail_Gorbachev_USSR.end", 
                 "start.Helpful_Stack_Overflow_People.end", "start.Im_A_Tall_Drink_Of_Water.end", 
                 "start.ICU_Days.end", "start.Sex_Code.end", "start.MAX_of_MLD.end", 
                 "start.Age.Group.end", NA, "start..end", "start.s_na_k_er.end", 
                 "start.snake_snake_case.end", "start.snake_snak_e_case.end", 
                 "start.snake_snak_e_case.end", "start.ss_r_rss.end", "start.ss_rrrr.end", 
                 "start.this_is_some_camel_case.end", "start.this.text.end", 
                 "start.final_count.end", "start.bob_dylan_usa.end", "start.mikhail_gorbachev_ussr.end", 
                 "start.helpful_stack_overflow_people.end", "start.im_a_tall_drink_of_water.end", 
                 "start.icu_days.end", "start.sex_code.end", "start.max_of_mld.end", 
                 "start.age.group.end", NA, "start..end", "start.sNaKEr.end", 
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
                 "start.THIS_IS_SOME_CAMEL_CASE.end", "start.THIS.TEXT.end", 
                 "start.FINAL_COUNT.end", "start.BOB_DYLAN_USA.end", "start.MIKHAIL_GORBACHEV_USSR.end", 
                 "start.HELPFUL_STACK_OVERFLOW_PEOPLE.end", "start.IM_A_TALL_DRINK_OF_WATER.end", 
                 "start.ICU_DAYS.end", "start.SEX_CODE.end", "start.MAX_OF_MLD.end", 
                 "start.AGE.GROUP.end"))
  }
)



test_that("sep_out", {
  paste_along <- function(x, along = "_") {
    if (length(x) <= 1L) return(x)
    if (length(along) == 1L) return(paste0(x, collapse = along))
    
    along <- c(along, rep_len(along[length(along)], max(length(x) - length(along), 0L)))
    paste0(paste0(x[seq_len(length(x) - 1)], along[seq_len(length(x) - 1)],
                  collapse = ""), x[length(x)])
  }

  expect_equal(to_any_case("a", sep_out = "-"), "a")
  expect_equal(to_any_case(""), "")
  expect_equal(to_any_case("a"), "a")
  expect_equal(to_any_case(c("bla_bla_bla"), sep_out = c("-", "_")),  "bla-bla_bla")
  
  expect_equal(to_any_case(c("2018_01_01_bla_bla_bla"), sep_out = c("-", "_")), "2018-01_01_bla_bla_bla")
  expect_equal(to_any_case(c("2018_01_01_bla_bla_bla"), sep_out = "-"), "2018-01-01-bla-bla-bla")
  expect_equal(to_any_case(c("2018_01_01_bla_bla"), sep_out = c("-", "-", "_", "_", "_", "_", "_")),  "2018-01-01_bla_bla")
  expect_equal(to_any_case(character(0), sep_out = c("_", "_")), character(0))
})

test_that("random case", {
  expect_equal(
    {suppressWarnings(RNGversion("3.1")); set.seed(123); to_any_case("almost RANDOM", case = "random")},
    "AlMosT raNdOm"
    )
})

test_that("title case", {
  expect_equal(
    to_any_case(c("on_andOn", "AndON", " and on", "and so on", "seems like it works", "also abbreviations ETC"), case = "title", abbreviations = "ETC"),
    c("On and on", "And on", "And on", "And so on", "Seems Like it Works", "Also Abbreviations ETC") 
  )
})

test_that("case none", {
  expect_equal(
    to_any_case(c("blabla", "blablub", "blaBlub"),case = "none", transliterations = c(blab = "blub")),
    c("blubla", "blublub", "blaBlub") 
  )
})

test_that("special_input", {
  expect_identical(to_any_case(NA_character_), NA_character_)
  expect_equal(to_any_case(character(0)), character(0))
})

test_that("special_input_2", {
  skip_if(getRversion() < 3.4)
  # atomics
  expect_equal(to_any_case(character()), character())
  expect_error(to_any_case(logical()), "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(integer()), "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(double()), "argument is not a character vector", fixed = TRUE)
  # data structures
  expect_error(to_any_case(data.frame()), "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(list())      , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(matrix())    , "argument is not a character vector", fixed = TRUE)
  # special input or wrong type
  expect_error(to_any_case(NA)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(NA_integer_)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(NA_real_)    , "argument is not a character vector", fixed = TRUE)
  expect_equal(to_any_case(NA_character_)    , NA_character_)

  expect_error(to_any_case(TRUE)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(1.0)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(1L)    , "argument is not a character vector", fixed = TRUE)
  expect_equal(to_any_case(c("a", 1L))    , c("a", "1"))
  
  expect_error(to_any_case(NULL)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(NaN)    , "argument is not a character vector", fixed = TRUE)
  expect_error(to_any_case(Inf)    , "argument is not a character vector", fixed = TRUE)
  })

test_that("abbreviations", {
  expect_equal(to_any_case("IDENTICALid3", abbreviations = "iD3"), "identical_id_3")
})

test_that("parsing_options", {
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = 1),
               "RRR_Studio_S_Studio_Studio"
               )
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = -1),
               "RRR_Studio_S_Studio_Studio"
               )
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = 2),
              "RRRS_tudio_SS_tudio_Studio"
              )
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = -2),
               "RRRS_tudio_SS_tudio_Studio"
               )
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = 3),
               "RRRStudio_SStudio_Studio"
               )
  
  expect_equal(to_any_case("RRRStudioSStudioStudio", case = "parsed", parsing_option = -3),
               "RRRStudio_SStudio_Studio"
               )
})

test_that("individual abbreviations", {
  
  expect_equal(
    to_any_case("NBAGame", abbreviations = "NBA", case = "mixed"),
    "NBA_Game"
  )
  
  expect_equal(
    to_any_case("NBAGame", abbreviations = "NBa", case = "mixed"),
    "NBa_Game"
  )
  
  expect_equal(
    to_any_case("NBAGame", abbreviations = "baa", case = "mixed"),
    "Nba_Game"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVP", case = "mixed"),
    "Game_MVP"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVp", case = "mixed"),
    "Game_MVp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "mvp", case = "mixed"),
    "Game_mvp"
  )
  
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "mvp", case = "upper_camel"),
    "GameMvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVP", case = "upper_camel"),
    "GameMVP"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVp", case = "upper_camel"),
    "GameMVp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "mvp", case = "title"),
    "Game Mvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVP", case = "title"),
    "Game MVP"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVp", case = "title"),
    "Game MVp"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "id", case = "title"),
    "User Id"
  )

  expect_equal(
    to_any_case("UserID", abbreviations = "ID", case = "title"),
    "User ID"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "id", case = "upper_camel"),
    "UserId"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "ID", case = "upper_camel"),
    "UserID"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "id", case = "mixed"),
    "User_id"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "ID", case= "mixed"),
    "User_ID"
  )
  
  expect_equal(
    to_any_case("UserID", abbreviations = "Id", case = "mixed"),
    "User_Id"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "mvp", case = "lower_camel"),
    "gameMvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVP", case = "lower_camel"),
    "gameMVP"
  )

  expect_equal(
    to_any_case("GameMVP", abbreviations = "MVp", case = "lower_camel"),
    "gameMVp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "GAME", case = "lower_camel"),
    "gameMvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "game", case = "lower_camel"),
    "gameMvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "gGame", case = "lower_camel"),
    "gameMvp"
  )
  
  expect_equal(
    to_any_case("GameMVP", abbreviations = "Game", case = "lower_camel"),
    "gameMvp"
    )
  
  expect_equal(
    to_any_case("nba_finals_mvp", abbreviations = c("nba", "MVP"), case = "upper_camel"),
    "NbaFinalsMVP"
  )
  
  expect_equal(
    to_any_case("nba_finals_mvp", abbreviations = c("nba", "MVp"), case = "upper_camel"),
    "NbaFinalsMVp"
  )
})


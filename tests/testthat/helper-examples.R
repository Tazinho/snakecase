cases <-
  tibble::tribble(
    ~nr, ~ examples          , ~snake_case         , ~small_camel_case   , ~big_camel_case     , ~screaming_snake_case ,
    #--|---------------------|---------------------|---------------------|---------------------|-----------------------|
    1  , NA                  , NA                  , NA                  , NA                  , NA,
    2  , "snake_case"        , "snake_case"        , "snakeCase"         , "SnakeCase"         , "SNAKE_CASE",
    3  , "snakeCase"         , "snake_case"        , "snakeCase"         , "SnakeCase"         , "SNAKE_CASE",
    4  , "SnakeCase"         , "snake_case"        , "snakeCase"         , "SnakeCase"         , "SNAKE_CASE",
    5  , "_"                 , ""                  , ""                  , ""                  , "",
    6  , "snake_Case"        , "snake_case"        , "snakeCase"         , "SnakeCase"         , "SNAKE_CASE",
    7  , "_"                 , ""                  , ""                  , ""                  , "",
    8  , "SNake"             , "s_nake"            , "sNake"             , "SNake"             , "S_NAKE",
    9  , "Snake"             , "snake"             , "snake"             , "Snake"             , "SNAKE",
    10 , "s_nake"            , "s_nake"            , "sNake"             , "SNake"             , "S_NAKE",
    11 , "sn_ake"            , "sn_ake"            , "snAke"             , "SnAke"             , "SN_AKE",
    12 , "_"                 , ""                  , ""                  , ""                  , "",
    13 , "SNaKE"             , "s_na_ke"           , "sNaKe"             , "SNaKe"             , "S_NA_KE",
    14 , "SNaKEr"            , "s_na_k_er"         , "sNaKEr"            , "SNaKEr"            , "S_NA_K_ER",
    15 , "s_na_k_er"         , "s_na_k_er"         , "sNaKEr"            , "SNaKEr"            , "S_NA_K_ER",
    16 , "_"                 , ""                  , ""                  , ""                  , "",
    17 , "SNAKE SNAKE CASE"  , "snake_snake_case"  , "snakeSnakeCase"    , "SnakeSnakeCase"    , "SNAKE_SNAKE_CASE",
    18 , "_"                 , ""                  , ""                  , ""                  , "",
    19 , "snakeSnakECase"    , "snake_snak_e_case" , "snakeSnakECase"    , "SnakeSnakECase"    , "SNAKE_SNAK_E_CASE",
    20 , "SNAKE snakE_case"  , "snake_snak_e_case" , "snakeSnakECase"    , "SnakeSnakECase"    , "SNAKE_SNAK_E_CASE",
    21 , "_"                 , ""                  , ""                  , ""                  , "",
    22 , "ssRRss"            , "ss_r_rss"          , "ssRRss"            , "SsRRss"            , "SS_R_RSS",
    23 , "ssRRRR"            , "ss_rrrr"           , "ssRrrr"            , "SsRrrr"            , "SS_RRRR"
    )
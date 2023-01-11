module I18n.Lang exposing
    ( Lang(..)
    , TextsNeedToBeTranslated
    , TranslateResult(..)
    , all
    , fromString
    , fromStringWithDefault
    , lang_end
    , toString
    )


type Lang
    = Zh_CN
    | En_US
    | Unknown


type TranslateResult
    = Translated String
    | NoNeedsToTranslate (List String)
    | WaitingToTranslate TextsNeedToBeTranslated


type alias TextsNeedToBeTranslated =
    { modules : List String, texts : List String }


lang_end : List String
lang_end =
    []


all : List ( Lang, String )
all =
    [ ( Zh_CN, "简体中文" )
    , ( En_US, "English" )
    ]


fromString : String -> Lang
fromString str =
    case String.toLower str of
        "zh_cn" ->
            Zh_CN

        "en_us" ->
            En_US

        _ ->
            Unknown


fromStringWithDefault : Lang -> String -> Lang
fromStringWithDefault defaultLang str =
    let
        lng =
            fromString str
    in
    case lng of
        Unknown ->
            defaultLang

        _ ->
            lng


toString : Lang -> String
toString l =
    case l of
        Zh_CN ->
            "zh_CN"

        En_US ->
            "en_US"

        _ ->
            ""

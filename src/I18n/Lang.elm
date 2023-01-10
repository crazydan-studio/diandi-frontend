module I18n.Lang exposing
    ( Lang(..)
    , TranslatedResult(..)
    , all
    , done
    , fromString
    , lang
    , toString
    )


type Lang
    = Zh_CN
    | En_US
    | Unknown


type TranslatedResult
    = Translated String
    | NoNeedsToTranslate (List String)
    | WaitingToTranslate (List String) (List String)


lang : String
lang =
    "@_@"


done : List String
done =
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


toString : Lang -> String
toString l =
    case l of
        Zh_CN ->
            "zh_CN"

        En_US ->
            "en_US"

        _ ->
            ""

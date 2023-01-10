module View.I18n.Home exposing (i18n)

import Element exposing (Element)
import I18n.Helper exposing (i18nElementText)
import I18n.Lang
    exposing
        ( Lang(..)
        , TranslatedResult(..)
        )
import View.I18n.Default


i18n : Lang -> List String -> Element msg
i18n langType originalTextList =
    i18nElementText (i18nTranslator langType) originalTextList


i18nWaiting : List String -> List String -> TranslatedResult
i18nWaiting textModules textList =
    WaitingToTranslate ("Home" :: textModules) textList


i18nWithLang :
    Lang
    -> List String
    -> List String
    -> TranslatedResult
i18nWithLang langType textModules textList =
    if langType == View.I18n.Default.lang then
        NoNeedsToTranslate textList

    else
        i18nWaiting textModules textList


i18nTranslator : Lang -> List String -> TranslatedResult
i18nTranslator langType textList =
    let
        defaultI18n =
            i18nWithLang langType
    in
    case textList of
        -- TopBar:: 用于区别文本相同，但国际化结果不同的信息
        ("TopBar" as m) :: actualTextList ->
            case actualTextList of
                [ "这里是类别描述信息" ] ->
                    case langType of
                        En_US ->
                            Translated
                                "Here is the description for the category"

                        _ ->
                            defaultI18n [ m ] actualTextList

                _ ->
                    i18nWaiting [ m ] actualTextList

        [ "待办" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("TODO (" ++ n ++ ")")

                _ ->
                    defaultI18n [] [ t, " (", n, ")" ]

        [ "知识" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Knowledge (" ++ n ++ ")")

                _ ->
                    defaultI18n [] [ t, " (", n, ")" ]

        [ "疑问" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Question (" ++ n ++ ")")

                _ ->
                    defaultI18n [] [ t, " (", n, ")" ]

        _ ->
            i18nWaiting [] textList

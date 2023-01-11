module View.I18n.Home exposing (i18nText)

import Element exposing (Element)
import I18n.Element
import I18n.Helper exposing (i18nWaiting)
import I18n.Lang
    exposing
        ( Lang(..)
        , TranslateResult(..)
        )
import View.I18n.Default


i18nText : Lang -> List String -> Element msg
i18nText =
    I18n.Element.text i18nTranslator


i18nTranslator : Lang -> List String -> TranslateResult
i18nTranslator langType texts =
    let
        i18nTopModule =
            "Home"

        i18nDefault subModules =
            View.I18n.Default.i18n langType (i18nTopModule :: subModules)
    in
    case texts of
        -- TopBar 用于区别文本相同但国际化结果不同的信息
        ("TopBar" as m) :: ([ "这里是类别描述信息" ] as actualTexts) ->
            case langType of
                En_US ->
                    Translated
                        "Here is the description for the category"

                _ ->
                    i18nDefault [ m ] actualTexts

        [ "待办" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("TODO (" ++ n ++ ")")

                _ ->
                    i18nDefault [] [ t, " (", n, ")" ]

        [ "知识" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Knowledge (" ++ n ++ ")")

                _ ->
                    i18nDefault [] [ t, " (", n, ")" ]

        [ "疑问" as t, n ] ->
            case langType of
                En_US ->
                    Translated
                        ("Question (" ++ n ++ ")")

                _ ->
                    i18nDefault [] [ t, " (", n, ")" ]

        _ ->
            i18nWaiting [ i18nTopModule ] texts

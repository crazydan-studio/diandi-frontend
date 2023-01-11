module View.I18n.Home exposing
    ( i18nBtnModule
    , i18nLabelModule
    , i18nText
    )

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


i18nRootModule : String
i18nRootModule =
    "Home"


i18nBtnModule : String
i18nBtnModule =
    "Btn"


i18nLabelModule : String
i18nLabelModule =
    "Label"


getI18nTranslatorBySubModule :
    String
    -> List ( String, t )
    -> Maybe t
getI18nTranslatorBySubModule subModule translators =
    translators
        |> List.foldl
            (\( m, t ) r ->
                if r == Nothing && m == subModule then
                    Just t

                else
                    r
            )
            Nothing


i18nTranslator : Lang -> List String -> TranslateResult
i18nTranslator langType texts =
    let
        i18nDefault subModules =
            View.I18n.Default.i18n langType (i18nRootModule :: subModules)
    in
    case texts of
        [ "又有什么奇妙的想法呢？赶紧记下来吧 :)" ] ->
            case langType of
                En_US ->
                    Translated
                        "Have any amazing ideas? Git it down right now :)"

                _ ->
                    i18nDefault [] texts

        [ "这里是类别描述信息" ] ->
            case langType of
                En_US ->
                    Translated
                        "Here is the description for the category"

                _ ->
                    i18nDefault [] texts

        [ "这里是主题详情展示页，默认显示当前分类的信息。注：实时预览也在这里" ] ->
            case langType of
                En_US ->
                    Translated
                        "Here is the details page for the topic, it will default show the information of the category. PS: Live preview is also here"

                _ ->
                    i18nDefault [] texts

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

        -- 处理子模块的国际化
        i18nSubModule :: actualTexts ->
            let
                translatorMaybe =
                    [ ( i18nBtnModule, i18nBtnTranslator )
                    , ( i18nLabelModule, i18nLabelTranslator )
                    ]
                        |> getI18nTranslatorBySubModule i18nSubModule
            in
            case translatorMaybe of
                Just translator ->
                    translator langType
                        i18nDefault
                        [ i18nRootModule, i18nSubModule ]
                        actualTexts

                Nothing ->
                    i18nWaiting [ i18nRootModule ] texts

        _ ->
            i18nWaiting [ i18nRootModule ] texts


i18nBtnTranslator :
    Lang
    -> (List String -> List String -> TranslateResult)
    -> List String
    -> List String
    -> TranslateResult
i18nBtnTranslator langType i18nDefault modules texts =
    case texts of
        [ "实时预览" ] ->
            case langType of
                En_US ->
                    Translated
                        "Live Preview"

                _ ->
                    i18nDefault [] texts

        [ "语言" ] ->
            case langType of
                En_US ->
                    Translated
                        "Language"

                _ ->
                    i18nDefault [] texts

        [ "记下来!" ] ->
            case langType of
                En_US ->
                    Translated
                        "Got it!"

                _ ->
                    i18nDefault [] texts

        _ ->
            i18nWaiting modules texts


i18nLabelTranslator :
    Lang
    -> (List String -> List String -> TranslateResult)
    -> List String
    -> List String
    -> TranslateResult
i18nLabelTranslator langType i18nDefault modules texts =
    case texts of
        [ "分类：" ] ->
            case langType of
                En_US ->
                    Translated
                        "Category: "

                _ ->
                    i18nDefault [] texts

        [ "标签：" ] ->
            case langType of
                En_US ->
                    Translated
                        "Tags: "

                _ ->
                    i18nDefault [] texts

        _ ->
            i18nWaiting modules texts

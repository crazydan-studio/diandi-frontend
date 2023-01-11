module I18n.Element exposing (text)

{-| Elm UI国际化支持

主要目的是将国际化结果直接转换为Elm UI元素，
并对未国际化的内容在元素的属性上做标记，
以便于统一展示未国际化内容

-}

import Element exposing (Attribute, Element)
import Html.Attributes as HtmlAttr
import I18n.Helper exposing (joinI18nModules, joinI18nTexts)
import I18n.Lang
    exposing
        ( Lang
        , TranslateResult(..)
        )


text :
    (Lang -> List String -> TranslateResult)
    -> Lang
    -> List String
    -> Element msg
text translator langType texts =
    case translator langType texts of
        Translated result ->
            Element.text result

        NoNeedsToTranslate result ->
            Element.text (joinI18nTexts result)

        WaitingToTranslate result ->
            -- 记录未做国际化的内容信息，便于通过js做统一展示处理
            Element.el
                (noTransAttrs result.modules)
                (Element.text (joinI18nTexts result.texts))


noTransAttrs : List String -> List (Attribute msg)
noTransAttrs modules =
    [ HtmlAttr.attribute "need-to-translate" "true"
        |> Element.htmlAttribute
    , HtmlAttr.attribute
        "need-to-translate-modules"
        (joinI18nModules modules)
        |> Element.htmlAttribute
    ]

module I18n.Helper exposing (i18nElementText, i18nHelper)

import Element exposing (Element)
import Html.Attributes as HtmlAttr
import I18n.Lang
    exposing
        ( TranslatedResult(..)
        , lang
        )


i18nHelper :
    (List String -> TranslatedResult)
    -> List String
    -> TranslatedResult
i18nHelper translator textList =
    let
        textListHead =
            textList |> List.head |> Maybe.withDefault ""

        actualTextList =
            if textListHead == lang then
                textList |> List.tail |> Maybe.withDefault []

            else
                textList
    in
    case actualTextList of
        [] ->
            Translated ""

        _ ->
            translator actualTextList


i18nElementText :
    (List String -> TranslatedResult)
    -> List String
    -> Element msg
i18nElementText translator textList =
    case i18nHelper translator textList of
        Translated str ->
            Element.text str

        NoNeedsToTranslate list ->
            Element.text (translateJoiner list)

        WaitingToTranslate textModules list ->
            -- 记录未做国际化的内容信息，便于通过js做统一展示处理
            Element.el
                [ HtmlAttr.attribute
                    "need-to-translate"
                    "true"
                    |> Element.htmlAttribute
                , HtmlAttr.attribute
                    "need-to-translate-module"
                    (textModules |> List.foldl (\m s -> s ++ "/" ++ m) "")
                    |> Element.htmlAttribute
                ]
                (Element.text (translateJoiner list))


translateJoiner : List String -> String
translateJoiner =
    List.foldr (++) ""

module I18n.I18n exposing
    ( I18nElement
    , I18nHtml
    , langTextEnd
    , withI18nElement
    , withI18nHtml
    )

import Element exposing (Element)
import Html exposing (Html)
import I18n.Lang exposing (Lang)


type alias I18nElement msg =
    (Lang
     -> List String
     -> Element msg
    )
    -> List String
    -> Element msg


type alias I18nHtml msg =
    (Lang
     -> List String
     -> Html msg
    )
    -> List String
    -> Html msg


langTextEnd : List String
langTextEnd =
    []


withI18nHtml :
    Lang
    ->
        (Lang
         -> List String
         -> Html msg
        )
    -> List String
    -> Html msg
withI18nHtml lang translate =
    translate lang


withI18nElement :
    Lang
    ->
        (Lang
         -> List String
         -> Element msg
        )
    -> List String
    -> Element msg
withI18nElement lang translate =
    translate lang

module I18n.I18n exposing
    ( I18nHtml
    , withI18nHtml
    )

import Html exposing (Html)
import I18n.Lang exposing (Lang)


type alias I18nHtml msg =
    (Lang
     -> List String
     -> Html msg
    )
    -> List String
    -> Html msg


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

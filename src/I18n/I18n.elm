module I18n.I18n exposing
    ( I18nElement
    , langTextEnd
    , withI18nElement
    )

import Element exposing (Element)
import I18n.Lang exposing (Lang)


type alias I18nElement msg =
    (Lang
     -> List String
     -> Element msg
    )
    -> List String
    -> Element msg


langTextEnd : List String
langTextEnd =
    []


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

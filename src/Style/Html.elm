module Style.Html exposing
    ( class
    , draggable
    , id
    , style
    )

{-| -}

import Element exposing (Attribute, htmlAttribute)
import Html.Attributes as HtmlAttr


id : String -> Attribute msg
id val =
    HtmlAttr.id val |> htmlAttribute


class : String -> Attribute msg
class val =
    HtmlAttr.class val |> htmlAttribute


style : String -> String -> Attribute msg
style name val =
    HtmlAttr.style name val |> htmlAttribute


draggable : String -> Attribute msg
draggable val =
    HtmlAttr.draggable val |> htmlAttribute

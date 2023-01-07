module Style.Html exposing
    ( allPointerEvents
    , class
    , cursor
    , draggable
    , id
    , noPointerEvents
    , noUserSelect
    , style
    , zIndex
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



-- TODO 参考Element UI实现css动态嵌入机制


zIndex : Int -> Attribute msg
zIndex val =
    style "z-index" (String.fromInt val)


cursor : String -> Attribute msg
cursor val =
    style "cursor" val


noUserSelect : Attribute msg
noUserSelect =
    style "user-select" "none"


noPointerEvents : Attribute msg
noPointerEvents =
    style "pointer-events" "none"


allPointerEvents : Attribute msg
allPointerEvents =
    style "pointer-events" "all"

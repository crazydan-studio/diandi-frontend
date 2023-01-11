module Widget.Helper exposing
    ( css
    , style
    , styles
    )

import Element
    exposing
        ( Attribute
        , htmlAttribute
        )
import Html.Attributes as HtmlAttr


style : String -> String -> Attribute msg
style name val =
    HtmlAttr.style name val |> htmlAttribute


styles : List ( String, String ) -> List (Attribute msg)
styles attrs =
    attrs
        |> List.map
            (\( name, val ) ->
                style name val
            )


css : String -> Attribute msg
css name =
    HtmlAttr.class name |> htmlAttribute

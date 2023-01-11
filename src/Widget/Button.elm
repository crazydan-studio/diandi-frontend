module Widget.Button exposing (primary)

import Element
    exposing
        ( Attribute
        , Element
        , focused
        , height
        , minimum
        , mouseOver
        , paddingXY
        , px
        , shrink
        , width
        )
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Theme.Color
import Theme.Color.Element
import Widget.Helper exposing (css)


primary :
    List (Attribute msg)
    ->
        { content : Element msg
        , onPress : Maybe msg
        }
    -> Element msg
primary attrs { content, onPress } =
    Input.button
        ([ width
            (shrink
                |> minimum 64
            )
         , height (px 36)
         , paddingXY 16 0
         , css "button"
         , Font.size 14
         , Font.letterSpacing 1.25
         , Border.rounded 4
         , mouseOver []
         , focused []
         ]
            ++ Theme.Color.Element.defaultPalette Theme.Color.Blue800
            ++ attrs
        )
        { onPress = onPress
        , label = content
        }

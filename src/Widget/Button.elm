module Widget.Button exposing
    ( link
    , primary
    )

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
import Theme.Theme
import Widget.Helper exposing (css)


{-| 主按钮
-}
primary :
    List (Attribute msg)
    ->
        { content : Element msg
        , onPress : Maybe msg
        , theme : Theme.Theme.Theme
        }
    -> Element msg
primary attrs { content, onPress, theme } =
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
            ++ Theme.Theme.primaryBtn theme
            ++ attrs
        )
        { onPress = onPress
        , label = content
        }


{-| 链接按钮
-}
link : Element msg
link =
    Element.none

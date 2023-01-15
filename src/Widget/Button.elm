module Widget.Button exposing
    ( Config
    , link
    , primary
    , secondary
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
import Widget.Model
    exposing
        ( Msg(..)
        , Widget
        , WidgetStateUpdater
        )
import Widget.Model.Button


type alias Config msg =
    { content : Element msg
    , onPress : Maybe msg
    , theme : Theme.Theme.Theme
    , attrs : List (Attribute msg)
    }


{-| 一级按钮
-}
primary : Widget msg -> Config msg -> Element msg
primary =
    btnCreator Theme.Theme.primaryBtn


{-| 二级按钮
-}
secondary : Widget msg -> Config msg -> Element msg
secondary =
    btnCreator Theme.Theme.secondaryBtn


{-| 链接按钮
-}
link : Element msg
link =
    Element.none



-- ---------------------------------------------------------------


btnCreator :
    (Theme.Theme.Theme -> List (Attribute msg))
    -> Widget msg
    -> Config msg
    -> Element msg
btnCreator fromTheme widget { content, onPress, theme, attrs } =
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
            ++ fromTheme theme
            ++ attrs
        )
        { onPress =
            Just
                (widget
                    |> onButtonMsg
                        (\state -> { state | disabled = not state.disabled })
                )
        , label = content
        }


onButtonMsg :
    WidgetStateUpdater Widget.Model.Button.State
    -> Widget msg
    -> msg
onButtonMsg updateState widget =
    widget
        |> Widget.Model.onMsg
            (\id ->
                UpdateButtonState
                    id
                    (\() -> Widget.Model.Button.init)
                    updateState
            )

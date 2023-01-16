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
        , WidgetUpdater
        , Widgets
        )
import Widget.Model.Button


type alias Config msg =
    { id : String
    , content : Element msg
    , onPress : Maybe msg
    , theme : Theme.Theme.Theme
    , attrs : List (Attribute msg)
    }


{-| 一级按钮
-}
primary : Widgets msg -> Config msg -> Element msg
primary =
    btnCreator Theme.Theme.primaryBtn


{-| 二级按钮
-}
secondary : Widgets msg -> Config msg -> Element msg
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
    -> Widgets msg
    -> Config msg
    -> Element msg
btnCreator fromTheme widgets { id, content, onPress, theme, attrs } =
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
                (widgets
                    |> onButtonMsg id
                        (\state ->
                            { state
                                | disabled = not state.disabled
                            }
                        )
                )
        , label = content
        }


onButtonMsg :
    String
    -> WidgetUpdater Widget.Model.Button.State
    -> Widgets msg
    -> msg
onButtonMsg id updateState =
    Widget.Model.onMsg
        (\() ->
            UpdateButtonState
                { id = id
                , init = \() -> Widget.Model.Button.init
                , update = updateState
                }
        )

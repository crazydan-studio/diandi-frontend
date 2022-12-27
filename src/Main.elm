module Main exposing (main)

import Browser
import Browser.Events exposing (onResize)
import Element exposing (Device, fill, height, width)
import Element.Font as Font
import Html exposing (Html)
import Html.Attributes as HtmlAttr


type alias Flags =
    { lang : String
    , width : Int
    , height : Int
    }


type alias AppModel =
    {
    }

type Msg = Noop | DeviceClassified Device

main : Program Flags AppModel Msg
main =
    -- Note: Browser.sandbox is not suitable for Flags
    -- for Browser.application:
    -- - https://gist.github.com/ohanhi/fb6546263965da956f6bfce8f78349e7
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( AppModel, Cmd Msg )
init flags =
    ( {
      }
    , Cmd.none
    )


subscriptions : AppModel -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onResize
            (\w h ->
                DeviceClassified
                    (Element.classifyDevice { width = w, height = h })
            )
        ]


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
    ( {
      }
    , Cmd.none
    )


view : AppModel -> Html Msg
view model =
    Element.layout
        [ Font.family
            [ Font.serif
            ]
        , width fill
        , height fill
        ]
        (Element.el
            [ HtmlAttr.id "_page_is_ready_" |> Element.htmlAttribute
            ]
            Element.none
        )

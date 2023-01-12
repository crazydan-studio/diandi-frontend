module View.Topic.ListView exposing (create)

import Element exposing (..)
import Element.Keyed
import Element.Lazy
import Model.Root exposing (RootModel)
import Model.Topic
import Msg exposing (RootMsg)
import Style.Topic
import Theme.Color
import Theme.Color.Element
import Widget.Markdown


create : RootModel -> Element RootMsg
create model =
    topicListView model.topics



-- ---------------------------------------------------------------


getPaletteWithDefault :
    Maybe Theme.Color.Color
    -> List (Attribute msg)
    -> List (Attribute msg)
getPaletteWithDefault bgColor defaultPalette =
    case bgColor of
        Just color ->
            Theme.Color.Element.defaultPalette color

        Nothing ->
            defaultPalette


topicListView : List Model.Topic.Topic -> Element RootMsg
topicListView topics =
    -- 列表增删改性能提升方案，同时lazy可确保在刷新页面时，有滚动条的列表的滚动位置可被浏览器记录，刷新后能够自动恢复浏览位置
    -- https://guide.elm-lang.org/optimization/keyed.html
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Keyed
    -- https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element-Lazy
    Element.Keyed.column
        Style.Topic.topicList
        (topics
            |> List.map
                (\topic ->
                    ( topic.id
                    , Element.Lazy.lazy topicView topic
                    )
                )
        )


topicView : Model.Topic.Topic -> Element RootMsg
topicView topic =
    column
        Style.Topic.topic
        [ row
            (Style.Topic.topicBody
                ++ getPaletteWithDefault topic.color
                    Style.Topic.topicBodyDefaultPalette
            )
            [ el
                [ width fill
                , padding 8
                ]
                (el
                    Style.Topic.contentInTopicBody
                    (paragraph
                        [ height shrink
                        , centerY
                        ]
                        [ Widget.Markdown.render topic.content
                        ]
                    )
                )
            ]
        ]

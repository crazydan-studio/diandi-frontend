module Widget.Part.Markdown exposing (Config, render)

{-| Markdown渲染参考示例

  - [对自定义标签bio的渲染](https://ellie-app.com/d7R3b9FsHfCa1)
  - [对TOC的渲染](https://ellie-app.com/cHB3fRSKVRha1)

-}

import Array
import Element exposing (Element)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Input
import Element.Region
import Html
import Html.Attributes
import Markdown.Block as Block
    exposing
        ( ListItem(..)
        , Task(..)
        )
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import Regex


type alias Config =
    { lineHeight : Int
    }


render : Config -> String -> Element msg
render config markdown =
    case markdownView config markdown of
        Ok rendered ->
            Element.column
                [ Element.width Element.fill
                , Element.centerX
                ]
                (rendered
                    ++ [ Html.node "style"
                            []
                            [ Html.text
                                -- 让checkbox始终居中显示
                                (".md-checkbox > .focusable"
                                    ++ " {vertical-align: middle;margin-top: -3px;}"
                                )
                            ]
                            |> Element.html
                       ]
                )

        Err errors ->
            Element.text errors


markdownView : Config -> String -> Result String (List (Element msg))
markdownView config markdown =
    markdown
        |> Markdown.Parser.parse
        |> Result.mapError
            (\error ->
                error
                    |> List.map Markdown.Parser.deadEndToString
                    |> String.join "\n"
            )
        |> Result.andThen (Markdown.Renderer.render (renderer config))


renderer : Config -> Markdown.Renderer.Renderer (Element msg)
renderer config =
    let
        r =
            elmUiRenderer config
    in
    { r
        | html =
            Markdown.Html.oneOf
                [ Markdown.Html.tag "img"
                    (\src width height _ ->
                        imgView src width height
                    )
                    |> Markdown.Html.withAttribute "src"
                    |> Markdown.Html.withOptionalAttribute "width"
                    |> Markdown.Html.withOptionalAttribute "height"
                ]
    }


imgView : String -> Maybe String -> Maybe String -> Element msg
imgView src width height =
    Element.image
        [ Element.width
            (case width of
                Just w ->
                    Element.px (Maybe.withDefault 0 (String.toInt w))

                Nothing ->
                    Element.fill
            )
        , Element.height
            (case height of
                Just h ->
                    Element.px (Maybe.withDefault 0 (String.toInt h))

                Nothing ->
                    Element.fill
            )
        ]
        { src = src, description = "" }


elmUiRenderer : Config -> Markdown.Renderer.Renderer (Element msg)
elmUiRenderer config =
    let
        lineHeight =
            Element.htmlStyleAttribute
                [ ( "line-height"
                  , String.fromInt config.lineHeight ++ "px"
                  )
                ]
    in
    { heading = heading
    , paragraph =
        Element.paragraph
            [ Element.spacing 0 ]
    , thematicBreak = Element.none
    , text =
        \text ->
            Element.el
                [ lineHeight
                ]
                (Element.text text)
    , strong = \content -> Element.row [ Font.bold ] content
    , emphasis = \content -> Element.row [ Font.italic ] content
    , strikethrough = \content -> Element.row [ Font.strike ] content
    , codeSpan = code
    , link =
        \{ title, destination } body ->
            Element.newTabLink
                [ Element.htmlAttribute (Html.Attributes.style "display" "inline-flex")
                ]
                { url = destination
                , label =
                    Element.paragraph
                        [ Font.color (Element.rgb255 0 0 255)
                        ]
                        body
                }
    , hardLineBreak = Html.br [] [] |> Element.html
    , image =
        \image ->
            let
                matched =
                    image.src
                        |> Regex.find
                            (Maybe.withDefault
                                Regex.never
                                (Regex.fromString
                                    -- image.src是编码后的字符串，且地址中不会包含空格
                                    "^(.+?)(%7C((\\d+)?(x(\\d+)?)?)?)?$"
                                )
                            )
                        |> List.map .submatches
                        |> List.concat
                        |> List.map (Maybe.withDefault "")
                        |> Array.fromList

                src =
                    Array.get 0 matched |> Maybe.withDefault image.src

                getSizeFrom i a =
                    Array.get i a
                        |> Maybe.withDefault ""
                        |> String.toInt
                        |> Maybe.map Element.px
                        |> Maybe.withDefault Element.fill

                width =
                    getSizeFrom 3 matched

                height =
                    getSizeFrom 5 matched
            in
            Element.image
                [ Element.width width
                , Element.height height
                ]
                { src = src
                , description = image.alt
                }
    , blockQuote =
        \children ->
            Element.column
                [ Element.Border.widthEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 10
                    }
                , Element.padding 10
                , Element.Border.color (Element.rgb255 145 145 145)
                , Element.Background.color (Element.rgb255 245 245 245)
                ]
                children
    , unorderedList =
        \items ->
            Element.column
                [ lineHeight
                ]
                (items
                    |> List.map
                        (\(ListItem task children) ->
                            Element.paragraph
                                [ Element.alignTop
                                , Element.spacing 0
                                ]
                                ((case task of
                                    IncompleteTask ->
                                        Element.row
                                            [ Element.htmlAttribute
                                                (Html.Attributes.class "md-checkbox")
                                            ]
                                            [ Element.Input.defaultCheckbox False ]

                                    CompletedTask ->
                                        Element.row
                                            [ Element.htmlAttribute
                                                (Html.Attributes.class "md-checkbox")
                                            ]
                                            [ Element.Input.defaultCheckbox True ]

                                    NoTask ->
                                        Element.text "•"
                                 )
                                    :: Element.text " "
                                    :: children
                                )
                        )
                )
    , orderedList =
        \startingIndex items ->
            Element.column
                [ lineHeight
                ]
                (items
                    |> List.indexedMap
                        (\index itemBlocks ->
                            Element.row []
                                [ Element.paragraph
                                    [ Element.alignTop
                                    , Element.spacing 0
                                    ]
                                    (Element.text
                                        (String.fromInt (index + startingIndex) ++ " ")
                                        :: itemBlocks
                                    )
                                ]
                        )
                )
    , codeBlock = codeBlock
    , html = Markdown.Html.oneOf []
    , table = Element.column []
    , tableHeader = Element.column []
    , tableBody = Element.column []
    , tableRow = Element.row []
    , tableHeaderCell =
        \maybeAlignment children ->
            Element.paragraph [] children
    , tableCell =
        \maybeAlignment children ->
            Element.paragraph [] children
    }


code : String -> Element msg
code snippet =
    Element.el
        [ Element.Background.color
            (Element.rgba 0 0 0 0.04)
        , Element.Border.rounded 2
        , Element.paddingXY 5 3
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text snippet)


codeBlock : { body : String, language : Maybe String } -> Element msg
codeBlock details =
    Element.el
        [ Element.Background.color (Element.rgba 0 0 0 0.03)
        , Element.htmlAttribute (Html.Attributes.style "white-space" "pre")
        , Element.padding 20
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text details.body)


heading : { level : Block.HeadingLevel, rawText : String, children : List (Element msg) } -> Element msg
heading { level, rawText, children } =
    Element.paragraph
        [ Font.size
            (case level of
                Block.H1 ->
                    36

                Block.H2 ->
                    24

                _ ->
                    20
            )
        , Font.bold
        , Font.family [ Font.typeface "Montserrat" ]
        , Element.Region.heading (Block.headingLevelToInt level)
        , Element.htmlAttribute
            (Html.Attributes.attribute "name" (rawTextToId rawText))
        , Element.htmlAttribute
            (Html.Attributes.id (rawTextToId rawText))
        ]
        children


rawTextToId rawText =
    rawText
        |> String.split " "
        |> Debug.log "split"
        |> String.join "-"
        |> Debug.log "joined"
        |> String.toLower

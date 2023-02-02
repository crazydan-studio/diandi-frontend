module View.Page.Home.Left exposing (view)

import Element exposing (..)
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Model
import Msg
import Theme.Theme as Theme
import View.I18n.Home as I18n
import View.Page.Topic.Category.List as CategoryList
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Icon as Icon
import Widget.Widget.Button as Button


view : Model.State -> Element Msg.Msg
view state =
    column
        [ width fill
        , height fill

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip
        ]
        [ header state
        , el
            [ width fill
            , height fill
            , scrollbarY
            ]
            (CategoryList.view state)
        , bottom state
        ]


headerHeight : Int
headerHeight =
    70


header : Model.State -> Element Msg.Msg
header { app, widgets } =
    let
        headerPaddingY =
            BaseStyle.spacing

        logoHeight =
            headerHeight - headerPaddingY * 2
    in
    row
        (PrimaryBorder.bottom 1 app.theme
            ++ [ width fill
               , height (px headerHeight)
               , paddingXY
                    BaseStyle.spacing2x
                    headerPaddingY
               ]
        )
        [ image
            [ width shrink
            , height (px logoHeight)
            , centerX
            , pointer
            ]
            { src = "/logo.svg", description = "", onLoad = Nothing }
        ]


bottom : Model.State -> Element Msg.Msg
bottom { app, widgets, withWidgetContext } =
    let
        i18nText =
            I18n.text app.lang
    in
    row
        (PrimaryBorder.top 1 app.theme
            ++ [ width fill
               , height shrink
               , padding BaseStyle.spacing
               ]
        )
        [ withWidgetContext <|
            Button.button
                { id = "btn-personal-setting-in-home"
                , attrs = Theme.secondaryBtn app.theme
                , content =
                    row
                        [ spacing BaseStyle.spacing
                        ]
                        [ app.theme
                            |> Theme.primaryBtnIcon
                                Icon.SettingOutlined
                        , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                          (I18n.btnModule :: "设置" :: langEnd)
                            |> i18nText
                        ]
                , onPress = Nothing
                }
        , Input.button
            [ alignRight
            , moveLeft 8
            ]
            { onPress = Nothing
            , label =
                row
                    [ spacing 2
                    ]
                    [ app.theme
                        |> Theme.primaryLinkBtnIcon
                            Icon.SearchOutlined
                    , (I18n.btnModule :: "搜索" :: langEnd)
                        |> i18nText
                    ]
            }
        ]

module View.Page.Home.Left exposing (view)

import Element exposing (..)
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Msg
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
header { app, theme } =
    let
        headerPaddingY =
            BaseStyle.spacing

        logoHeight =
            headerHeight - headerPaddingY * 2
    in
    row
        (PrimaryBorder.bottom 1 theme
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
bottom { app, theme, withI18nElement, withWidgetContext } =
    let
        i18nText =
            withI18nElement I18n.text
    in
    row
        (PrimaryBorder.top 1 theme
            ++ [ width fill
               , height shrink
               , padding BaseStyle.spacing
               ]
        )
        [ withWidgetContext <|
            Button.button
                { id = "btn-personal-setting-in-home"
                , attrs = theme.secondaryBtn
                , content =
                    row
                        [ spacing BaseStyle.spacing
                        ]
                        [ theme.primaryBtnIcon
                            Icon.SettingOutlined
                        , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                          (I18n.buttonText :: "设置" :: langTextEnd)
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
                    [ theme.primaryLinkBtnIcon
                        Icon.SearchOutlined
                    , (I18n.buttonText :: "搜索" :: langTextEnd)
                        |> i18nText
                    ]
            }
        ]

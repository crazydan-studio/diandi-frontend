module Style.Default exposing
    ( boundaryBorderAll
    , boundaryBorderEach
    , primaryFontColor
    , primaryFontSize
    , secondaryFontSize
    )

{-| -}

import Element exposing (Attribute, Color, rgb255)
import Element.Border as Border
import Theme.Color
import Theme.Color.Element


{-| 一级字体大小
-}
primaryFontSize : Int
primaryFontSize =
    14


{-| 一级字体颜色
-}
primaryFontColor : Color
primaryFontColor =
    Theme.Color.Element.toRgbColor Theme.Color.Blue600


{-| 二级字体大小
-}
secondaryFontSize : Int
secondaryFontSize =
    12


{-| 各边的样式
-}
boundaryBorderEach :
    { bottom : Int
    , left : Int
    , right : Int
    , top : Int
    }
    -> List (Attribute msg)
boundaryBorderEach width =
    [ Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.widthEach width
    ]


{-| 所有边的样式
-}
boundaryBorderAll : Int -> List (Attribute msg)
boundaryBorderAll width =
    [ Border.solid
    , Border.color (rgb255 223 225 230)
    , Border.width width
    ]

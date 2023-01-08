module Style.Basic exposing
    ( boundaryBorderAll
    , boundaryBorderEach
    , juniorFontSize
    , majorFontColor
    , majorFontSize
    , minorFontSize
    )

{-| -}

import Element exposing (Attribute, Color, rgb255)
import Element.Border as Border


{-| 主要字体大小
-}
majorFontSize : Int
majorFontSize =
    14


{-| 主要字体颜色
-}
majorFontColor : Color
majorFontColor =
    rgb255 6 126 213


{-| 次要字体大小
-}
minorFontSize : Int
minorFontSize =
    12


{-| 最次要字体大小
-}
juniorFontSize : Int
juniorFontSize =
    10


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

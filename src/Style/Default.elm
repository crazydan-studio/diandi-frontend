module Style.Default exposing
    ( boundaryBorderAll
    , boundaryBorderEach
    )

{-| -}

import Element exposing (Attribute, rgb255)
import Element.Border as Border


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

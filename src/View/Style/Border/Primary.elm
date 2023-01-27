module View.Style.Border.Primary exposing
    ( bottom
    , each
    , left
    , right
    , top
    )

import Element exposing (Attribute)
import Element.Border as Border
import Theme.Theme exposing (Theme)


{-| 设置边的主样式
-}
each :
    { top : Int
    , left : Int
    , right : Int
    , bottom : Int
    }
    -> Theme
    -> List (Attribute msg)
each size theme =
    [ Border.solid
    , Border.color (Theme.Theme.primaryBorderColor theme)
    , Border.widthEach size
    ]


top :
    Int
    -> Theme
    -> List (Attribute msg)
top size =
    each
        { top = size
        , left = 0
        , right = 0
        , bottom = 0
        }


bottom :
    Int
    -> Theme
    -> List (Attribute msg)
bottom size =
    each
        { top = 0
        , left = 0
        , right = 0
        , bottom = size
        }


left :
    Int
    -> Theme
    -> List (Attribute msg)
left size =
    each
        { top = 0
        , left = size
        , right = 0
        , bottom = 0
        }


right :
    Int
    -> Theme
    -> List (Attribute msg)
right size =
    each
        { top = 0
        , left = 0
        , right = size
        , bottom = 0
        }

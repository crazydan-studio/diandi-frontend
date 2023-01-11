module Theme.Type.All exposing (themes)

import Theme.Theme exposing (Theme)
import Theme.Type.Default


themes : List ( String, Theme )
themes =
    [ ( "默认主题", Theme.Type.Default.theme )
    ]

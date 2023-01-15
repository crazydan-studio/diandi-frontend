module Theme.Type.Default exposing (theme)

import Theme.Color
import Theme.Theme exposing (Theme)


theme : Theme
theme =
    { primaryFontSize = 14
    , primaryFontColor = Theme.Color.Blue600
    , secondaryFontSize = 12
    , primaryBtnColor = Theme.Color.Blue800
    , secondaryBtnColor = Theme.Color.Purple800
    , placeholderFontColor = Theme.Color.Grey500
    }

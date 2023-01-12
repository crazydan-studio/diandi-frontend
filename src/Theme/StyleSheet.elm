module Theme.StyleSheet exposing (create)

import Html exposing (Html)
import Theme.Theme


create : Theme.Theme.Theme -> Html msg
create theme =
    Html.node "style"
        []
        [ -- 原始的 .s.r > .s 选择的文本宽度始终为0
          Html.text ".button > .s.r > .s {flex-basis: auto;}"
        ]

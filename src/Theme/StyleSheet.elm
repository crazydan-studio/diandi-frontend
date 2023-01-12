module Theme.StyleSheet exposing (create)

import Html exposing (Html)
import Theme.Theme


create : Theme.Theme.Theme -> Html msg
create _ =
    Html.node "style"
        []
        [ -- 隐藏加载动画，显示body下的元素
          Html.text "body::after {opacity: 0;} body > * {opacity: 1;}"

        -- 原始的 .s.r > .s 选择的文本宽度始终为0
        , Html.text ".button > .s.r > .s {flex-basis: auto;}"
        ]

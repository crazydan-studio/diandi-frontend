module Theme.StyleSheet exposing (create)

import Html exposing (Html)
import Theme.Theme


create : Theme.Theme.Theme -> Html msg
create _ =
    Html.node "style"
        []
        [ -- 隐藏加载动画，显示body下的元素
          Html.text "body::after {opacity: 0;} body > * {opacity: 1;}"

        -- 解决原始的 .s.r > .s 选择的文本宽度始终为0的问题
        , Html.text
            (([ ".s.r > .s.button"
              , ".button > .s.r > .s"
              ]
                |> String.join ","
             )
                ++ " {flex-basis: auto;}"
            )
        ]

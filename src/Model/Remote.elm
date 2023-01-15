module Model.Remote exposing (parseError)

import Http


parseError : Http.Error -> String
parseError error =
    case error of
        Http.BadStatus status ->
            if status == 401 then
                "用户未登录"

            else if status == 403 then
                "请求未授权"

            else if status == 404 then
                "请求URL不存在"

            else
                "异常请求状态码：" ++ String.fromInt status

        Http.Timeout ->
            "网络请求超时，请稍后再试"

        Http.NetworkError ->
            "网络连接异常，请稍后再试"

        _ ->
            "未知异常"

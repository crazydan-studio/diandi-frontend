module Remote exposing
    ( RemoteMsg(..)
    , getAllMyTopicCategories
    , getAllMyTopics
    , getMyUserInfo
    , logout
    , parseError
    , queryMyTopicCategories
    , queryMyTopics
    )

import Http
import Model.Topic exposing (Topic, topicListDecoder)
import Model.Topic.Category exposing (Category, categoryListDecoder)
import Model.User exposing (UserInfo, userInfoDecoder)


type RemoteMsg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)
    | UserLogout (Result Http.Error ())
    | QueryMyTopics (Result Http.Error (List Topic))
    | QueryMyTopicCategories (Result Http.Error (List Category))


{-| 获取当前用户的用户信息
-}
getMyUserInfo : Cmd RemoteMsg
getMyUserInfo =
    Http.get
        { url = "/demo/me.json"
        , expect = Http.expectJson GotMyUserInfo userInfoDecoder
        }


{-| 用户退出
-}
logout : Cmd RemoteMsg
logout =
    Http.get
        { url = "/auth/logout"
        , expect = Http.expectWhatever UserLogout
        }


getAllMyTopics : Cmd RemoteMsg
getAllMyTopics =
    queryMyTopics {}


queryMyTopics : {} -> Cmd RemoteMsg
queryMyTopics _ =
    Http.get
        { url = "/demo/topics.json"
        , expect = Http.expectJson QueryMyTopics topicListDecoder
        }


getAllMyTopicCategories : Cmd RemoteMsg
getAllMyTopicCategories =
    queryMyTopicCategories {}


queryMyTopicCategories : {} -> Cmd RemoteMsg
queryMyTopicCategories _ =
    Http.get
        { url = "/demo/categories.json"
        , expect = Http.expectJson QueryMyTopicCategories categoryListDecoder
        }


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

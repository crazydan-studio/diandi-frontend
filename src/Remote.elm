module Remote exposing
    ( RemoteMsg(..)
    , getAllMyTopics
    , getMyUserInfo
    , logout
    , queryMyTopics
    )

import Http
import Model.Topic exposing (Topic, topicListDecoder)
import Model.User exposing (UserInfo, userInfoDecoder)


type RemoteMsg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)
    | UserLogout (Result Http.Error ())
    | QueryMyTopics (Result Http.Error (List Topic))


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
queryMyTopics param =
    Http.get
        { url = "/demo/topics.json"
        , expect = Http.expectJson QueryMyTopics topicListDecoder
        }

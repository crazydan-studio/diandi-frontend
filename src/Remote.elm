module Remote exposing
    ( RemoteMsg(..)
    , getAllMyCards
    , getMyUserInfo
    , logout
    , queryMyCards
    )

import Http
import Model.Card exposing (Card, cardListDecoder)
import Model.User exposing (UserInfo, userInfoDecoder)


type RemoteMsg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)
    | UserLogout (Result Http.Error ())
    | QueryMyCards (Result Http.Error (List Card))


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


getAllMyCards : Cmd RemoteMsg
getAllMyCards =
    queryMyCards {}


queryMyCards : {} -> Cmd RemoteMsg
queryMyCards param =
    Http.get
        { url = "/demo/cards.json"
        , expect = Http.expectJson QueryMyCards cardListDecoder
        }

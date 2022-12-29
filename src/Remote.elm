module Remote exposing (RemoteMsg(..), getMyUserInfo, logout)

import Http
import Model.User exposing (UserInfo, userInfoDecoder)


type RemoteMsg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)
    | UserLogout (Result Http.Error ())


{-| 获取当前用户的用户信息
-}
getMyUserInfo : Cmd RemoteMsg
getMyUserInfo =
    Http.get
        { url = "/auth/user"
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

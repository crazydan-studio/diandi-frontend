module Remote exposing (RemoteMsg(..), getMyUserInfo)

import Http
import Model.User exposing (UserInfo, userInfoDecoder)


type RemoteMsg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)


{-| 获取当前用户的用户信息
-}
getMyUserInfo : Cmd RemoteMsg
getMyUserInfo =
    Http.get
        { url = "/auth/user"
        , expect = Http.expectJson GotMyUserInfo userInfoDecoder
        }

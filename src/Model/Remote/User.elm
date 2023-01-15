module Model.Remote.User exposing (getMyUserInfo)

import Http
import Model.Remote.Msg exposing (Msg(..))
import Model.User exposing (userInfoDecoder)


{-| 获取当前用户的用户信息
-}
getMyUserInfo : Cmd Msg
getMyUserInfo =
    Http.get
        { url = "/demo/me.json"
        , expect = Http.expectJson GotMyUserInfo userInfoDecoder
        }

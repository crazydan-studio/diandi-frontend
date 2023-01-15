module Model.Remote.Auth exposing (logout)

import Http
import Model.Remote.Msg exposing (Msg(..))


{-| 用户退出
-}
logout : Cmd Msg
logout =
    Http.get
        { url = "/auth/logout"
        , expect = Http.expectWhatever UserLogout
        }

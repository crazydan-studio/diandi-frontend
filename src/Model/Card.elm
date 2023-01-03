module Model.Card exposing
    ( Card
    , Color
    , Tag
    , cardDecoder
    , cardListDecoder
    )

{-| -}

import Json.Decode as Decode
    exposing
        ( Decoder
        , int
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)


{-| 点滴卡

任务、知识等内容的载体

-}
type alias Card =
    { id : String
    , content : String
    , tags : List Tag

    -- 颜色表: https://blog.avada.io/css/color-palettes#material-design-color-palette-badboy
    , bgColor : Maybe Color
    , fgColor : Maybe Color

    -- 上级卡片id
    , superior : String

    -- 创建信息
    , createdAt : String
    }


type alias Color =
    { r : Int, g : Int, b : Int }


type alias Tag =
    String


cardListDecoder : Decoder (List Card)
cardListDecoder =
    list cardDecoder


cardDecoder : Decoder Card
cardDecoder =
    Decode.succeed Card
        |> required "id" string
        |> required "content" string
        |> required "tags" (list cardTagDecoder)
        |> optional "bgColor" (nullable colorDecoder) Nothing
        |> optional "fgColor" (nullable colorDecoder) Nothing
        |> optional "superior" string ""
        |> required "createdAt" string


cardTagDecoder : Decoder Tag
cardTagDecoder =
    Decode.string


colorDecoder : Decoder Color
colorDecoder =
    Decode.succeed Color
        |> required "r" int
        |> required "g" int
        |> required "b" int

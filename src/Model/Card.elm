module Model.Card exposing
    ( Card
    , Tag
    , cardDecoder
    , cardListDecoder
    )

{-| -}

import Json.Decode as Decode
    exposing
        ( Decoder
        , list
        , nullable
        , string
        )
import Json.Decode.Pipeline exposing (optional, required)
import Model.ColorPalette exposing (Palette, maybePaletteDecoder)


{-| 点滴卡

任务、知识等内容的载体

-}
type alias Card =
    { id : String

    -- 父卡片id
    , superior : Maybe String

    -- 前序卡片id
    , previous : Maybe String

    --
    , content : String
    , tags : List Tag

    -- 调色板
    , colorPalette : Maybe Palette

    -- 创建信息
    , createdAt : String
    }


type alias Tag =
    String


cardListDecoder : Decoder (List Card)
cardListDecoder =
    list cardDecoder


cardDecoder : Decoder Card
cardDecoder =
    Decode.succeed Card
        |> required "id" string
        |> optional "superior" (nullable string) Nothing
        |> optional "previous" (nullable string) Nothing
        |> required "content" string
        |> required "tags" (list cardTagDecoder)
        |> optional "colorPalette" maybePaletteDecoder Nothing
        |> required "createdAt" string


cardTagDecoder : Decoder Tag
cardTagDecoder =
    Decode.string

module Model.Topic exposing
    ( Tag
    , Topic
    , topicDecoder
    , topicListDecoder
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
type alias Topic =
    { id : String

    -- 父卡片id
    , superior : Maybe String

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


topicListDecoder : Decoder (List Topic)
topicListDecoder =
    list topicDecoder


topicDecoder : Decoder Topic
topicDecoder =
    Decode.succeed Topic
        |> required "id" string
        |> optional "superior" (nullable string) Nothing
        |> required "content" string
        |> required "tags" (list topicTagDecoder)
        |> optional "color_palette" maybePaletteDecoder Nothing
        |> required "created_at" string


topicTagDecoder : Decoder Tag
topicTagDecoder =
    Decode.string

module Model.Topic exposing
    ( Topic
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
import Theme.Color exposing (maybeColorDecoder)


{-| 点滴卡

任务、知识等内容的载体

-}
type alias Topic =
    { id : String

    -- 父卡片id
    , superior : Maybe String

    --
    , content : String
    , category : Maybe String
    , tags : List String

    -- 配色
    , color : Maybe Theme.Color.Color

    -- 创建信息
    , createdAt : String
    }


topicListDecoder : Decoder (List Topic)
topicListDecoder =
    list topicDecoder


topicDecoder : Decoder Topic
topicDecoder =
    Decode.succeed Topic
        |> required "id" string
        |> optional "superior" (nullable string) Nothing
        |> required "content" string
        |> optional "category" (nullable string) Nothing
        |> optional "tags" (list string) []
        |> optional "color" maybeColorDecoder Nothing
        |> required "created_at" string

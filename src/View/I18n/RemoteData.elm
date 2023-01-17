module View.I18n.RemoteData exposing
    ( text
    , textWithResult
    )

import Element exposing (Element)
import I18n.Element
import I18n.Helper exposing (translateWaiting)
import I18n.Lang
    exposing
        ( Lang(..)
        , TranslateResult(..)
        )
import View.I18n.Default


text : Lang -> List String -> Element msg
text =
    I18n.Element.text translator


textWithResult : TranslateResult -> Element msg
textWithResult =
    I18n.Element.textWithResult


translator : Lang -> List String -> TranslateResult
translator langType texts =
    let
        translateDefault =
            View.I18n.Default.translator langType []
    in
    case texts of
        [ "数据未加载" ] ->
            case langType of
                En_US ->
                    Translated "Data isn't loaded"

                _ ->
                    translateDefault texts

        [ "数据加载中，请稍候..." ] ->
            case langType of
                En_US ->
                    Translated "Loading data, please wait a monment ..."

                _ ->
                    translateDefault texts

        _ ->
            translateWaiting [] texts

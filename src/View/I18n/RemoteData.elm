module View.I18n.RemoteData exposing
    ( text
    , textWithResult
    , translate
    )

import Element exposing (Element)
import I18n.Element
import I18n.Lang exposing (Lang(..))
import I18n.Translator as Translator
    exposing
        ( TranslateResult
        , default
        , ok
        )
import View.I18n.Default as Default


text : Lang -> List String -> Element msg
text =
    I18n.Element.text translate


textWithResult : TranslateResult -> Element msg
textWithResult =
    I18n.Element.textWithResult


translate : Lang -> List String -> TranslateResult
translate lang texts =
    Translator.translate Default.lang lang texts <|
        [ ( [], translator )
        ]


translator : List String -> List ( Lang, TranslateResult )
translator texts =
    case texts of
        [ "数据未加载" ] ->
            ok En_US "Data isn't loaded"
                :: default

        [ "数据加载中，请稍候..." ] ->
            ok En_US "Loading data, please wait a monment ..."
                :: default

        [ "数据已加载，但结果为空" ] ->
            ok En_US "Data is loaded, but the result is empty"
                :: default

        _ ->
            default

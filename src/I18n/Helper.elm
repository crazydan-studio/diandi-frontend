module I18n.Helper exposing
    ( i18nTextJoiner
    , i18nWaiting
    , i18nWaitingByLang
    )

import I18n.Lang exposing (Lang, TranslateResult(..))


{-| 拼接国际化文本
-}
i18nTextJoiner : List String -> String
i18nTextJoiner =
    List.foldr (++) ""


{-| 返回结果[WaitingToTranslate](I18n.Lang#WaitingToTranslate)
-}
i18nWaiting : List String -> List String -> TranslateResult
i18nWaiting modules texts =
    WaitingToTranslate { modules = modules, texts = texts }


{-| 根据默认Lang和当前Lang确定结果是否为[WaitingToTranslate](I18n.Lang#WaitingToTranslate)

当前Lang与默认Lang相同时，返回`NoNeedsToTranslate`，否则，返回`WaitingToTranslate`

-}
i18nWaitingByLang :
    { default : Lang, current : Lang }
    -> List String
    -> List String
    -> TranslateResult
i18nWaitingByLang lang modules texts =
    if lang.current == lang.default then
        NoNeedsToTranslate texts

    else
        i18nWaiting modules texts

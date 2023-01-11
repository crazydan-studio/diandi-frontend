module I18n.Helper exposing
    ( i18nWaiting
    , i18nWaitingByLang
    , joinI18nModules
    , joinI18nTexts
    , splitI18nModulesFrom
    )

import I18n.Lang exposing (Lang, TranslateResult(..))


{-| 拼接国际化文本
-}
joinI18nTexts : List String -> String
joinI18nTexts =
    String.join ""


{-| 拼接国际化模块
-}
joinI18nModules : List String -> String
joinI18nModules =
    String.join "/"


{-| 从字符串中拆分出国际化模块
-}
splitI18nModulesFrom : String -> List String
splitI18nModulesFrom =
    String.split "/"


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

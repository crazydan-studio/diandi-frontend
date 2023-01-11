module View.I18n.Default exposing (i18n, lang)

import I18n.Helper exposing (i18nWaitingByLang)
import I18n.Lang exposing (Lang, TranslateResult)


lang : Lang
lang =
    I18n.Lang.Zh_CN


i18n :
    Lang
    -> List String
    -> List String
    -> TranslateResult
i18n langType modules =
    i18nWaitingByLang
        { default = lang
        , current = langType
        }
        modules

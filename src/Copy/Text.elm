module Copy.Text exposing (t)

import Copy.Keys exposing (Key(..))



-- The translate function


t : Key -> String
t key =
    case key of
        SiteUrl ->
            "https://[cCc]"

        SiteTitle ->
            "[cCc]"

        --- Site Meta
        IndexPageMetaTitle ->
            "Home"

        IndexPageMetaDescription ->
            "[cCc]"

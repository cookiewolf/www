module Page.Index exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, div, h2, text)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.View


view : Model -> Html Msg
view _ =
    div []
        [ h2 [] [ text (t WhatWeDoH2) ]
        , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
        , h2 [] [ text (t ThingsWeWorkOnH2) ]
        , div [] [ text "[cCc] Case study list #23" ]
        , h2 [] [ text (t WhoWeAreH2) ]
        , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
        , div [] [ text "[cCc] Who we are list #24" ]
        , Theme.View.markdownToHtml (t WhoWeAreMarkdown2)
        ]

module Page.Index exposing (view)

import Copy.CaseStudy exposing (CaseStudyKey(..))
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, a, div, h2, text)
import Html.Styled.Attributes exposing (href)
import Model exposing (Model)
import Msg exposing (Msg)
import Route
import Theme.View


view : Model -> Html Msg
view _ =
    div []
        [ h2 [] [ text (t WhatWeDoHeading) ]
        , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
        , h2 [] [ text (t ThingsWeWorkOnHeading) ]
        , div []
            [ div [] [ text "[cCc] Case study list #23" ]
            , a [ href (Route.toString (Route.CaseStudy (Copy.CaseStudy.caseStudyFromId Foyer).slug)) ] [ text (Copy.CaseStudy.caseStudyFromId Foyer).title ]
            ]
        , h2 [] [ text (t WhoWeAreHeading) ]
        , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
        , div [] [ text "[cCc] Who we are list #24" ]
        , Theme.View.markdownToHtml (t WhoWeAreMarkdown2)
        ]

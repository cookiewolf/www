module Page.CaseStudy exposing (view)

import Copy.CaseStudy exposing (CaseStudy)
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, div, h1, text)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.View


view : Model -> CaseStudy -> Html Msg
view _ caseStudy =
    div []
        [ div [] [ text (t (Category Copy.Keys.CaseStudy)) ]
        , h1 [] [ text caseStudy.title ]
        , Theme.View.markdownToHtml caseStudy.introMarkdown
        ]

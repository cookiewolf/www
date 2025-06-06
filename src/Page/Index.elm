module Page.Index exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, div, h2, p, text)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.View


view : Model -> Html Msg
view _ =
    div []
        [ h2 [] [ text (t WhatWeDoH2) ]
        , p [] [ text (t WhatWeDoP) ]
        , h2 [] [ text (t WhoWeAreH2) ]
        , p [] [ text (t WhoWeAreP) ]
        , h2 [] [ text (t WhatWeBelieveH2) ]
        , Theme.View.markdownToHtml (t WhatWeBelieveP)
        , h2 [] [ text (t HowMuchWeCostH2) ]
        , p [] [ text (t HowMuchWeCostP) ]
        , Theme.View.markdownToHtml (t HowMuchWeCostUl)
        , h2 [] [ text (t HowToContactUsH2) ]
        , Theme.View.markdownToHtml (t HowToContactUsP)
        ]

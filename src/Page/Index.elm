module Page.Index exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, div, h2, p, text)
import Html.Styled.Attributes exposing (css)
import Model exposing (Model)
import Msg exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text (t WhatWeDoH2) ]
        , p [] [ text (t WhatWeDoP) ]
        , h2 [] [ text (t WhoWeAreH2) ]
        , p [] [ text (t WhoWeAreP) ]
        , h2 [] [ text (t WhatWeBelieveH2) ]
        , p [] [ text (t WhatWeBelieveP) ]
        , h2 [] [ text (t HowMuchWeCostH2) ]
        , p [] [ text (t HowMuchWeCostP) ]
        , h2 [] [ text (t HowToContactUsH2) ]
        , p [] [ text (t HowToContactUsP) ]
        ]

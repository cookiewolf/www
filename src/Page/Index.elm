module Page.Index exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, div, h1, p, text)
import Html.Styled.Attributes exposing (css)
import Model exposing (Model)
import Msg exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (t SiteTitle) ]
        , p [] [ text (t WhatWeDo) ]
        , p [] [ text (t WhoWeAre) ]
        ]

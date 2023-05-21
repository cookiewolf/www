module Theme.View exposing (viewPageWrapper)

import Html.Styled exposing (Html, div, img, text)
import Html.Styled.Attributes exposing (css, src, style)
import Msg exposing (Msg)
import VitePluginHelper


viewPageWrapper : Html Msg -> Html Msg
viewPageWrapper pageContent =
    div []
        [ img [ src <| VitePluginHelper.asset "/src/assets/logo.png", style "width" "300px" ] []
        , pageContent
        ]

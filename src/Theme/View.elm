module Theme.View exposing (viewPageWrapper)

import Copy.Keys exposing (Key)
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, div, h1, img, text)
import Html.Styled.Attributes exposing (css, id, src, style)
import Msg exposing (Msg)
import Theme.Style exposing (globalStyles)
import VitePluginHelper


viewPageWrapper : Key -> Html Msg -> Html Msg
viewPageWrapper pageTitle pageContent =
    div [ id ("page-" ++ generateId (t pageTitle)), css [ pagewrapperStyle ] ]
        [ globalStyles
        , viewPageHeader pageTitle
        , pageContent
        ]


viewPageHeader : Key -> Html Msg
viewPageHeader pageTitle =
    div []
        [ img [ src <| VitePluginHelper.asset "/src/assets/logo.png", style "width" "300px" ] []
        , h1 [] [ text (t pageTitle) ]
        ]


pagewrapperStyle : Style
pagewrapperStyle =
    batch
        [ margin2 zero auto
        , maxWidth (px 1200)
        , width (pct 100)
        ]



-- Helpers


generateId : String -> String
generateId input =
    String.trim (String.replace " " "-" (String.toLower input))

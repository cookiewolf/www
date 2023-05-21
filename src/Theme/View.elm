module Theme.View exposing (viewPageWrapper)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, div, h1, img, text)
import Html.Styled.Attributes exposing (css, id, src, style)
import Msg exposing (Msg)
import Theme.Style exposing (blue, globalStyles, withMediaTablet)
import VitePluginHelper


viewPageWrapper : Key -> Html Msg -> Html Msg
viewPageWrapper pageTitle pageContent =
    div [ id ("page-" ++ generateId (t pageTitle)), css [ pagewrapperStyle ] ]
        [ globalStyles
        , viewPageHeader
        , div [ css [ containerStyle ] ] [ pageContent ]
        ]


viewPageHeader : Html Msg
viewPageHeader =
    div [ css [ pageHeaderStyle ] ]
        [ img [ src <| VitePluginHelper.asset "/src/assets/logo.png", css [ logoImageStyle ] ] []
        , h1 [ css [ headingStyle ] ] [ text (t SiteTitle) ]
        ]


pagewrapperStyle : Style
pagewrapperStyle =
    batch
        [ margin2 zero auto
        , maxWidth (px 800)
        , width (pct 100)
        ]


pageHeaderStyle : Style
pageHeaderStyle =
    batch
        [ alignItems center
        , displayFlex
        , justifyContent center
        , padding2 zero (rem 1)
        , withMediaTablet [ justifyContent end ]
        ]


headingStyle : Style
headingStyle =
    batch
        [ color blue.dark
        , fontSize (rem 3)
        , outline none
        , padding2 (rem 2) zero
        , textAlign center
        , withMediaTablet
            [ fontSize (rem 4.2) ]
        ]


logoImageStyle : Style
logoImageStyle =
    batch
        [ width (px 110)
        , withMediaTablet [ width (px 150) ]
        ]


containerStyle : Style
containerStyle =
    batch
        [ margin2 zero auto
        , maxWidth (px 800)
        , padding2 zero (rem 1)
        , width (pct 100)
        ]



-- Helpers


generateId : String -> String
generateId input =
    String.trim (String.replace " " "-" (String.toLower input))

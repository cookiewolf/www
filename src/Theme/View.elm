module Theme.View exposing (markdownToHtml, viewPageWrapper)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, div, h1, h2, img, p, text)
import Html.Styled.Attributes exposing (alt, css, id, src)
import Markdown
import Msg exposing (Msg)
import Theme.Style exposing (globalStyles, green, withMediaTablet)
import VitePluginHelper


viewPageWrapper : String -> Html Msg -> Html Msg
viewPageWrapper pageTitle pageContent =
    div [ id ("page-" ++ generateId pageTitle), css [ pagewrapperStyle ] ]
        [ globalStyles
        , viewPageHeader
        , div [ css [ containerStyle ] ] [ pageContent ]
        , viewPageFooter
        ]


viewPageHeader : Html Msg
viewPageHeader =
    div [ css [ pageHeaderStyle ] ]
        [ img
            [ src (VitePluginHelper.asset "/src/assets/logo.png")
            , alt ""
            , css [ logoImageStyle ]
            ]
            []
        , div []
            [ h1 [ css [ headingStyle ] ] [ text (t SiteTitle) ]
            , div [ css [ straplineStyle ] ] [ text (t Strapline) ]
            ]
        ]


viewPageFooter : Html Msg
viewPageFooter =
    div [ css [ footerStyle ] ]
        [ h2 [] [ text (t ContactUsHeading) ]
        , markdownToHtml (t ContactUsMarkdown)
        , p [] [ text (t CompanyInformation) ]
        ]


pagewrapperStyle : Style
pagewrapperStyle =
    batch
        [ margin4 zero auto (rem 0.5) auto
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
        [ color green.dark
        , fontSize (rem 2.6)
        , outline none
        , padding zero
        , textAlign center
        , withMediaTablet
            [ fontSize (rem 4.2) ]
        ]


straplineStyle : Style
straplineStyle =
    batch
        [ fontWeight bold
        , textAlign center
        ]


logoImageStyle : Style
logoImageStyle =
    batch
        [ width (px 140)
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


footerStyle : Style
footerStyle =
    batch
        [ fontSize (rem 0.75)
        , paddingTop (rem 2)
        , textAlign center
        ]



-- Helpers


generateId : String -> String
generateId input =
    String.trim (String.replace " " "-" (String.toLower input))


markdownToHtml : String -> Html msg
markdownToHtml text =
    Markdown.toHtml [] text
        |> Html.Styled.fromUnstyled

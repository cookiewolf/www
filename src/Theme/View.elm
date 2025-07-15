module Theme.View exposing (contentContainer, markdownToHtml, viewPageWrapper)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, footer, h2, header, p, text)
import Html.Styled.Attributes exposing (css, href, id)
import Markdown
import Msg exposing (Msg)
import Theme.Style exposing (black, globalStyles, green, pink, white, withMediaTablet)
import VitePluginHelper


viewPageWrapper : String -> Html Msg -> Html Msg
viewPageWrapper pageTitle pageContent =
    div [ id ("page-" ++ generateId pageTitle), css [ viewPageStyle ] ]
        [ globalStyles
        , viewPageHeader
        , div [ css [] ] [ pageContent ]
        , viewPageFooter
        ]


viewPageHeader : Html Msg
viewPageHeader =
    header [ css [ pageHeaderBackgroundStyle ] ]
        [ div [ css [ contentContainer ] ]
            [ div
                [ css [ pageHeaderStyle ]
                ]
                [ a [ css [ headingStyle ], href "/" ] [ text (t SiteTitle) ]
                , div [ css [ straplineStyle ] ] [ text (t Strapline) ]
                ]
            ]
        ]


viewPageFooter : Html Msg
viewPageFooter =
    footer [ css [ footerStyle ] ]
        [ div [ css [ contentContainer ] ]
            [ h2 [ css [ footerHeadingStyle ] ] [ text (t ContactUsHeading) ]
            , div []
                [ markdownToHtml (t ContactUsMarkdown)
                ]
            , p [ css [ footerInfoStyle ] ] [ text (t CompanyInformation) ]
            ]
        ]


contentContainer : Style
contentContainer =
    batch
        [ margin2 zero auto
        , maxWidth (px 1000)
        , width (pct 100)
        ]


pageHeaderStyle : Style
pageHeaderStyle =
    batch
        [ alignItems center
        , backgroundImage (url (VitePluginHelper.asset "/src/assets/background.jpg"))
        , backgroundPosition center
        , backgroundSize cover
        , displayFlex
        , flexDirection column
        , justifyContent center
        , padding (rem 3)
        ]


pageHeaderBackgroundStyle : Style
pageHeaderBackgroundStyle =
    backgroundColor green.dark


viewPageStyle : Style
viewPageStyle =
    batch
        [ displayFlex
        , flexDirection column
        , height (vh 100)
        ]


headingStyle : Style
headingStyle =
    batch
        [ borderBottom (px 0)
        , color white
        , fontSize (rem 2.6)
        , fontWeight (int 700)
        , outline none
        , padding zero
        , textAlign center
        , textTransform uppercase
        , withMediaTablet [ fontSize (rem 4.2) ]
        , hover
            [ backgroundColor transparent
            , borderBottom (px 0)
            , color green.light
            ]
        ]


straplineStyle : Style
straplineStyle =
    batch
        [ backgroundColor green.mid
        , color black
        , fontWeight bold
        , padding2 (rem 0.1) (rem 0.5)
        , textAlign center
        ]


containerStyle : Style
containerStyle =
    batch
        [ margin2 zero auto
        , padding2 zero (rem 1)
        , width (pct 100)
        ]


footerStyle : Style
footerStyle =
    batch
        [ backgroundColor green.dark
        , color white
        , fontSize (rem 1.25)
        , marginTop auto
        , padding4 (rem 2) (rem 2) (rem 3) (rem 2)
        , textAlign center
        ]


footerHeadingStyle : Style
footerHeadingStyle =
    batch
        [ fontSize (rem 2)
        , marginBottom (rem 1.5)
        ]


footerInfoStyle : Style
footerInfoStyle =
    batch
        [ color pink.mid
        , marginTop (rem 3)
        ]



-- Helpers


generateId : String -> String
generateId input =
    String.trim (String.replace " " "-" (String.toLower input))


markdownToHtml : String -> Html msg
markdownToHtml text =
    Markdown.toHtml [] text
        |> Html.Styled.fromUnstyled

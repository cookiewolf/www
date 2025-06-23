module Theme.View exposing (markdownToHtml, viewPageWrapper)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h2, header, p, text)
import Html.Styled.Attributes exposing (css, href, id)
import Markdown
import Msg exposing (Msg)
import Theme.Style exposing (black, globalStyles, green, white, withMediaTablet)
import VitePluginHelper


viewPageWrapper : String -> Html Msg -> Html Msg
viewPageWrapper pageTitle pageContent =
    div [ id ("page-" ++ generateId pageTitle) ]
        [ globalStyles
        , viewPageHeader
        , div [ css [ containerStyle ] ] [ pageContent ]
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
    div [ css [ footerStyle ] ]
        [ h2 [] [ text (t ContactUsHeading) ]
        , markdownToHtml (t ContactUsMarkdown)
        , p [] [ text (t CompanyInformation) ]
        ]


contentContainer : Style
contentContainer =
    batch
        [ margin4 zero auto (rem 0.5) auto
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


headingStyle : Style
headingStyle =
    batch
        [ color white
        , fontSize (rem 2.6)
        , fontWeight (int 700)
        , outline none
        , padding zero
        , textAlign center
        , textTransform uppercase
        , withMediaTablet
            [ fontSize (rem 4.2) ]
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

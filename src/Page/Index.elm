module Page.Index exposing (view)

import Copy.AboutUs
import Copy.CaseStudy exposing (CaseStudyKey(..))
import Copy.Keys exposing (Key(..), Section(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h2, img, section, text)
import Html.Styled.Attributes exposing (alt, class, css, href, src, title)
import Model exposing (Model)
import Msg exposing (Msg)
import Route
import Theme.Style exposing (pink)
import Theme.View


view : Model -> Html Msg
view _ =
    div []
        [ h2 [] [ text (t WhatWeDoHeading) ]
        , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
        , h2 [] [ text (t ThingsWeWorkOnHeading) ]
        , div []
            [ div [] [ text "[cCc] Case study list #23" ]
            , a [ href (Route.toString (Route.CaseStudy (Copy.CaseStudy.caseStudyFromId Foyer).slug)) ] [ text (Copy.CaseStudy.caseStudyFromId Foyer).title ]
            ]
        , section [ css [ whoWeAreSectionStyle ], class "about-us" ]
            [ h2 [ css [ whoWeAreHeadingStyle ] ] [ text (t WhoWeAreHeading) ]
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
            , ul
                [ css [ imageRowStyle ] ]
                (viewWhoWeAreList Copy.AboutUs.profiles)
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown2)
            ]
        ]


viewWhoWeAreList : List Model.ProfileInfo -> List (Html Msg)
viewWhoWeAreList profiles =
    List.map
        (\profile ->
            li [ class "profile-item" ]
                [ a [ href ("/about-us#" ++ String.toLower (String.replace " " "-" profile.name)), class "profile-link" ]
                    [ viewProfileImage profile
                    ]
                ]
        )
        profiles


viewProfileImage : Model.ProfileInfo -> Html Msg
viewProfileImage profile =
    img [ src profile.imagePath, css [ imageStyle ], alt profile.name ] []



-- Styles


whoWeAreSectionStyle : Style
whoWeAreSectionStyle =
    batch
        [ margin2 (rem 3) auto
        , textAlign center
        ]


whoWeAreHeadingStyle : Style
whoWeAreHeadingStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , margin2 (rem 2) auto
        ]


imageRowStyle : Style
imageRowStyle =
    batch
        [ displayFlex
        , overflowX auto
        , margin2 (rem 3) (rem -1)
        ]


imageStyle : Style
imageStyle =
    batch
        [ borderRadius (px 500)
        , flexShrink zero
        , height (rem 7)
        , property "object-fit" "cover"
        , width (rem 7)
        ]

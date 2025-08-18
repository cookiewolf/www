module Page.Index exposing (view)

import Copy.AboutUs
import Copy.CaseStudy exposing (CaseStudyKey(..))
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, h2, img, li, p, section, text, ul)
import Html.Styled.Attributes exposing (alt, class, css, href, src)
import Model
import Msg exposing (Msg)
import Theme.Style exposing (fuchsia, pink, shadow, white, withMediaTablet)
import Theme.View exposing (generateId)


featuredCaseStudyList : List Copy.CaseStudy.CaseStudyKey
featuredCaseStudyList =
    [ Foyer, CodeReadingClub, NewProjectInvite ]


view : Html Msg
view =
    div []
        [ section [ css [ sectionStyle ], class "home-section" ]
            [ h1 [ css [ sectionHeadingStyle ] ] [ text (t WhatWeDoHeading) ]
            , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
            ]
        , section [ css [ sectionStyle, sectionHighlightStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text (t ThingsWeWorkOnHeading) ]
            , ul [ css [ workListStyle ] ] (viewWorkingOnList featuredCaseStudyList)
            ]
        , section [ css [ sectionStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text (t WhoWeAreHeading) ]
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
            , ul
                [ css [ imageRowStyle ] ]
                (viewWhoWeAreList Copy.AboutUs.profiles)
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown2)
            ]
        ]


viewWorkingOnList : List Copy.CaseStudy.CaseStudyKey -> List (Html Msg)
viewWorkingOnList featuredCaseStudies =
    List.map
        (\caseStudyId ->
            let
                caseStudy : Model.CaseStudy
                caseStudy =
                    Copy.CaseStudy.caseStudyFromId caseStudyId
            in
            li [ css [ workingOnCardStyle ] ] (viewCaseStudyCard caseStudy)
        )
        featuredCaseStudies


viewCaseStudyCard : Model.CaseStudy -> List (Html Msg)
viewCaseStudyCard caseStudy =
    [ viewCaseStudyCardHeader caseStudy
    , viewCaseStudyCardSummary caseStudy
    , viewCaseStudyCardLink caseStudy
    ]


viewCaseStudyCardHeader : Model.CaseStudy -> Html Msg
viewCaseStudyCardHeader caseStudy =
    img [ src caseStudy.teaserBackgroundSrc, alt caseStudy.name, css [ cardImageStyle ] ] []


viewCaseStudyCardSummary : Model.CaseStudy -> Html Msg
viewCaseStudyCardSummary caseStudy =
    p [] [ text caseStudy.teaserSummary ]


viewCaseStudyCardLink : Model.CaseStudy -> Html Msg
viewCaseStudyCardLink caseStudy =
    a [ href caseStudy.teaserHref ] [ text caseStudy.teaserLinkText ]


viewWhoWeAreList : List Model.ProfileInfo -> List (Html Msg)
viewWhoWeAreList profiles =
    List.map
        (\profile ->
            li [ class "profile-item" ]
                [ a
                    [ href ("/about-us#" ++ generateId profile.name)
                    , class "profile-link"
                    , Html.Styled.Attributes.target "_self"
                    ]
                    [ viewProfileImage profile
                    , div [ css [ overlayStyle ] ] []
                    , div [ css [ overlayLabelStyle ] ] [ text profile.name ]
                    ]
                ]
        )
        profiles


viewProfileImage : Model.ProfileInfo -> Html Msg
viewProfileImage profile =
    img [ src profile.imagePath, css [ imageStyle ], alt profile.name ] []



-- Styles


sectionStyle : Style
sectionStyle =
    batch
        [ padding2 (rem 3) zero
        , textAlign center
        ]


sectionHighlightStyle : Style
sectionHighlightStyle =
    batch
        [ backgroundColor pink.light
        , boxShadow4 (px 0) (px 0) (px 20) shadow
        ]


sectionHeadingStyle : Style
sectionHeadingStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , marginBottom (rem 2)
        ]


workListStyle : Style
workListStyle =
    batch
        [ displayFlex
        , flexDirection column
        , fontSize (rem 1)
        , listStyle none
        , margin auto
        , maxWidth (px 1000)
        , padding zero
        , withMediaTablet
            [ flexDirection row
            ]
        ]


workingOnCardStyle : Style
workingOnCardStyle =
    batch
        [ alignItems center
        , displayFlex
        , flexDirection column
        , marginBottom (rem 3)
        , padding2 zero (rem 1)
        , withMediaTablet
            [ marginBottom zero
            ]
        ]


cardImageStyle : Style
cardImageStyle =
    batch
        [ borderRadius (px 20)
        , maxWidth (pct 60)
        ]


imageRowStyle : Style
imageRowStyle =
    batch
        [ displayFlex
        , overflowX auto
        , margin2 (rem 3) auto
        , padding zero
        ]


imageStyle : Style
imageStyle =
    batch
        [ borderRadius (px 500)
        , height (rem 7)
        , property "object-fit" "cover"
        , width (rem 7)
        ]


overlayStyle : Style
overlayStyle =
    batch
        [ alignItems center
        , backgroundColor fuchsia
        , borderRadius (px 500)
        , display none
        , height (rem 7)
        , justifyContent center
        , position absolute
        , property "mix-blend-mode" "multiply"
        , top zero
        , width (rem 7)
        ]


overlayLabelStyle : Style
overlayLabelStyle =
    batch
        [ alignItems center
        , borderRadius (px 500)
        , color white
        , display none
        , fontWeight (int 700)
        , height (rem 7)
        , justifyContent center
        , position absolute
        , property "word-spacing" "7rem"
        , top zero
        , width (rem 7)
        ]

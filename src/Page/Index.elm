module Page.Index exposing (view)

import Copy.AboutUs
import Copy.CaseStudy exposing (CaseStudyKey(..))
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h2, h3, img, li, p, section, text, ul)
import Html.Styled.Attributes exposing (alt, class, css, href, src)
import Model
import Msg exposing (Msg)
import Theme.Style exposing (fuchsia, pink, white)
import Theme.View exposing (generateId)


featuredCaseStudyList : List Copy.CaseStudy.CaseStudyKey
featuredCaseStudyList =
    [ Foyer, CodeReadingClub, NewProjectInvite ]


view : Html Msg
view =
    div []
        [ section [ css [ sectionStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text (t WhatWeDoHeading) ]
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
            li [] [ viewCaseStudyCard caseStudy ]
        )
        featuredCaseStudies


viewCaseStudyCard : Model.CaseStudy -> Html Msg
viewCaseStudyCard caseStudy =
    div []
        [ viewCaseStudyCardHeader caseStudy
        , viewCaseStudyCardSummary caseStudy
        , viewCaseStudyCardLink caseStudy
        ]


viewCaseStudyCardHeader : Model.CaseStudy -> Html Msg
viewCaseStudyCardHeader caseStudy =
    div [ css [ workingOnCardStyle caseStudy.teaserBackgroundSrc ] ]
        (case caseStudy.maybeTeaserLogoSrc of
            Nothing ->
                [ h3 [] [ text caseStudy.title ] ]

            Just aLogoSrc ->
                [ img [ src aLogoSrc, alt "" ] []
                , h3 [ css [ Theme.Style.visuallyHiddenStyles ] ] [ text caseStudy.title ]
                ]
        )


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
                [ a [ href ("/about-us#" ++ generateId profile.name), class "profile-link" ]
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


workingOnCardStyle : String -> Style
workingOnCardStyle src =
    batch
        [ backgroundImage (url src)
        , backgroundSize cover
        , borderRadius (px 20)
        , height (px 200)
        , width (px 200)
        ]


sectionStyle : Style
sectionStyle =
    batch
        [ margin2 (rem 3) auto
        , textAlign center
        ]


sectionHighlightStyle : Style
sectionHighlightStyle =
    batch
        [ backgroundColor pink.light
        ]


sectionHeadingStyle : Style
sectionHeadingStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , margin2 (rem 2) auto
        ]


workListStyle : Style
workListStyle =
    batch
        [ listStyle none
        , displayFlex
        ]


imageRowStyle : Style
imageRowStyle =
    batch
        [ displayFlex
        , overflowX auto
        , margin2 (rem 3) auto
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

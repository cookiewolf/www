module Page.Index exposing (view)

import Copy.AboutUs
import Copy.CaseStudy exposing (CaseStudyKey(..))
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h2, h3, img, li, p, section, text, ul)
import Html.Styled.Attributes exposing (alt, class, css, href, src, title)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.Style exposing (pink)
import Theme.View


featuredCaseStudyList : List Copy.CaseStudy.CaseStudyKey
featuredCaseStudyList =
    [ Foyer, CodeReadingClub, NewProjectInvite ]


view : Html Msg
view =
    div []
        [ h2 [] [ text (t WhatWeDoHeading) ]
        , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
        , h2 [] [ text (t ThingsWeWorkOnHeading) ]
        , ul [] (viewWorkingOnList featuredCaseStudyList)
        , section [ css [ whoWeAreSectionStyle ], class "about-us" ]
            [ h2 [ css [ whoWeAreHeadingStyle ] ] [ text (t WhoWeAreHeading) ]
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
            , div
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
            a [ href ("/about-us#" ++ profile.name), class "profile-link", title profile.name ] (viewProfileImage profile)
        )
        profiles


viewProfileImage : Model.ProfileInfo -> List (Html Msg)
viewProfileImage profile =
    [ img [ src profile.imagePath, css [ imageStyle ], alt profile.name ] []
    ]



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

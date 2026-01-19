module Page.Index exposing (view)

import Array exposing (Array)
import Copy.AboutUs
import Copy.CaseStudy
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, h2, img, li, p, section, text, ul)
import Html.Styled.Attributes exposing (alt, class, css, href, src)
import Model
import Msg exposing (Msg)
import Page.Blog as Blog
import Route
import Theme.Style exposing (fuchsia, green, pink, shadow, white, withMediaTablet)
import Theme.View exposing (generateId)


featuredCaseStudyList : List Model.CaseStudy
featuredCaseStudyList =
    [ Copy.CaseStudy.foyer
    , Copy.CaseStudy.codeReadingClub
    , Copy.CaseStudy.newProjectInvite
    ]


view : Array Model.BlogPost -> Html Msg
view blogPosts =
    div []
        [ -- hero banner
          section [ css [ sectionStyle ], class "home-section" ]
            [ h1 [ css [ sectionHeadingStyle ] ] [ text (t WhatWeDoHeading) ]
            , Theme.View.markdownToHtml (t WhatWeDoMarkdown)
            ]

        -- case studies
        , section [ css [ sectionStyle, sectionHighlightStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text (t ThingsWeWorkOnHeading) ]
            , ul [ css [ workListStyle ] ] (viewWorkingOnList featuredCaseStudyList)
            ]

        -- who we are
        , section [ css [ sectionStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text (t WhoWeAreHeading) ]
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown1)
            , ul
                [ css [ imageRowStyle ] ]
                (viewWhoWeAreList Copy.AboutUs.profiles)
            , Theme.View.markdownToHtml (t WhoWeAreMarkdown2)
            ]

        -- blog sample
        , section [ css [ sectionStyle, sectionAltHighlightStyle ], class "home-section" ]
            [ h2 [ css [ sectionHeadingStyle ] ] [ text <| t BlogHomeTitle ]
            , Blog.viewBlogCardPromo blogPosts
            , p [] [ a [ href <| Route.toString Route.BlogIndex ] [ text <| t BlogHomeReadMoreLink ] ]
            ]
        ]


viewWorkingOnList : List Model.CaseStudy -> List (Html Msg)
viewWorkingOnList featuredCaseStudies =
    featuredCaseStudies
        |> List.map
            (\caseStudy ->
                li [ css [ workingOnCardStyle ] ] (viewCaseStudyCard caseStudy)
            )


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


sectionAltHighlightStyle : Style
sectionAltHighlightStyle =
    batch
        [ backgroundColor green.light
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


writingListStyle : Style
writingListStyle =
    batch
        [ displayFlex
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

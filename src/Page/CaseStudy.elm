module Page.CaseStudy exposing (sectionLayoutStyle, view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, aside, blockquote, div, h1, h2, hr, img, p, section, text)
import Html.Styled.Attributes exposing (alt, css, src)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.Style exposing (pink, shadow, withMediaTablet)
import Theme.View exposing (contentContainer)


view : Model -> Model.CaseStudy -> Html Msg
view _ caseStudy =
    div []
        [ section []
            [ div [ css [ titleBackgroundStyle ] ]
                [ div [ css [ contentContainer, titleAreaStyle ] ]
                    [ div [ css [ caseStudyStyle ] ] [ text (t (Category Copy.Keys.CaseStudy)) ]
                    , h1 [ css [ titleStyle ] ] [ text caseStudy.title ]
                    ]
                ]
            , div [ css [ contentContainer, sectionLayoutStyle ] ]
                [ div [ css [ contentStyle ] ]
                    [ Theme.View.markdownToHtml caseStudy.introMarkdown
                    ]
                , aside [ css [ asideStyle ] ]
                    [ viewMaybeImage caseStudy.maybeIntroImage
                    ]
                ]
            ]
        , hr [ css [ hrStyle ] ] []
        , div [ css [ contentContainer, sectionLayoutStyle ] ]
            [ div [ css [ contentStyle ] ]
                [ h2 [ css [ sectionHeadingStyle ] ] [ text (t WhatWeDidHeading) ]
                , Theme.View.markdownToHtml caseStudy.whatWeDidMarkdown
                ]
            , aside [ css [ asideStyle ] ]
                [ viewMaybeImage caseStudy.maybeWhatWeDidImage
                ]
            ]
        , hr [ css [ hrStyle ] ] []
        , div [ css [ contentContainer, sectionLayoutStyle ] ]
            [ div []
                [ h2 [ css [ sectionHeadingStyle ] ] [ text (t ResultsHeading) ]
                , Theme.View.markdownToHtml caseStudy.resultsMarkdown
                ]
            , aside []
                [ viewMaybeQuote caseStudy.maybeQuote
                ]
            ]
        ]


viewMaybeImage : Maybe Model.Image -> Html Msg
viewMaybeImage maybeImage =
    case maybeImage of
        Just anImage ->
            img [ src anImage.src, alt anImage.alt ] []

        Nothing ->
            text ""


viewMaybeQuote : Maybe Model.Quote -> Html Msg
viewMaybeQuote maybeQuote =
    case maybeQuote of
        Just aQuote ->
            div []
                [ blockquote [] [ text aQuote.quote ]
                , p [] [ text aQuote.author ]
                , p [] [ text aQuote.source ]
                ]

        Nothing ->
            text ""



-- Styles


titleBackgroundStyle : Style
titleBackgroundStyle =
    batch
        [ backgroundColor pink.light
        , boxShadow4 (px 0) (px 0) (px 20) shadow
        , withMediaTablet
            [ padding2 (rem 2) (rem 1)
            ]
        ]


titleAreaStyle : Style
titleAreaStyle =
    batch
        [ padding2 (rem 2) (rem 1)
        ]


caseStudyStyle : Style
caseStudyStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , fontWeight bold
        ]


titleStyle : Style
titleStyle =
    batch
        [ fontSize (rem 2.5)
        , fontWeight bold
        , lineHeight (rem 3)
        , withMediaTablet
            [ fontSize (rem 3.75)
            , lineHeight (rem 4.5)
            ]
        ]


sectionLayoutStyle : Style
sectionLayoutStyle =
    batch
        [ displayFlex
        , flexDirection column
        , fontSize (rem 1.25)
        , padding2 (rem 2) (rem 1)
        , withMediaTablet
            [ flexDirection row
            , padding2 (rem 3) (rem 1)
            ]
        ]


contentStyle : Style
contentStyle =
    batch
        [ flexBasis (pct 60)
        ]


asideStyle : Style
asideStyle =
    batch
        [ flexBasis (pct 40)
        ]


sectionHeadingStyle : Style
sectionHeadingStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , marginBottom (rem 2)
        ]


hrStyle : Style
hrStyle =
    batch
        [ border3 (px 1) dashed pink.dark
        ]

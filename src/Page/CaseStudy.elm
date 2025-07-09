module Page.CaseStudy exposing (sectionLayoutStyle, view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, blockquote, div, h1, h2, hr, img, p, section, text)
import Html.Styled.Attributes exposing (alt, css, src)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.Style exposing (pink, shadow, withMediaTablet)
import Theme.View exposing (contentContainer)


view : Model -> Model.CaseStudy -> Html Msg
view _ caseStudy =
    div []
        [ section []
            [ div [ css [ titleAreaStyle ] ]
                [ div [ css [ contentContainer ] ]
                    [ div [ css [ caseStudyStyle ] ] [ text (t (Category Copy.Keys.CaseStudy)) ]
                    , h1 [ css [ titleStyle ] ] [ text caseStudy.title ]
                    ]
                ]
            , div [ css [ contentContainer, sectionLayoutStyle ] ]
                [ div []
                    [ Theme.View.markdownToHtml caseStudy.introMarkdown
                    ]
                , div []
                    [ viewMaybeImage caseStudy.maybeIntroImage
                    ]
                ]
            ]
        , hr [ css [ hrStyle ] ] []
        , div [ css [ contentContainer, sectionLayoutStyle ] ]
            [ div []
                [ h2 [ css [ sectionHeadingStyle ] ] [ text (t WhatWeDidHeading) ]
                , Theme.View.markdownToHtml caseStudy.whatWeDidMarkdown
                ]
            , div []
                [ viewMaybeImage caseStudy.maybeWhatWeDidImage
                ]
            ]
        , hr [ css [ hrStyle ] ] []
        , div [ css [ contentContainer, sectionLayoutStyle ] ]
            [ div []
                [ h2 [ css [ sectionHeadingStyle ] ] [ text (t ResultsHeading) ]
                , Theme.View.markdownToHtml caseStudy.resultsMarkdown
                ]
            , div []
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


titleAreaStyle : Style
titleAreaStyle =
    batch
        [ backgroundColor pink.light
        , boxShadow4 (px 0) (px 0) (px 20) shadow
        , padding2 (rem 3) zero
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
        , withMediaTablet [ fontSize (rem 3.75), lineHeight (rem 4.5) ]
        ]


sectionLayoutStyle : Style
sectionLayoutStyle =
    batch
        [ displayFlex
        , flexDirection column
        , padding2 (rem 3) (rem 1)
        , withMediaTablet [ flexDirection row ]
        ]


sectionHeadingStyle : Style
sectionHeadingStyle =
    batch
        [ color pink.dark
        , fontSize (rem 2)
        , margin2 (rem 2) auto
        ]


hrStyle : Style
hrStyle =
    batch
        [ border3 (px 1) dashed pink.dark
        ]

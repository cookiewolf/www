module Page.CaseStudy exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, blockquote, div, h1, h2, img, p, text)
import Html.Styled.Attributes exposing (alt, src)
import Model exposing (Model)
import Msg exposing (Msg)
import Theme.View


view : String -> Model.CaseStudyContent -> Html Msg
view caseStudyTitle caseStudy =
    div []
        [ div [] [ text (t (Category Copy.Keys.CaseStudy)) ]
        , div []
            [ div []
                [ h1 [] [ text caseStudyTitle ]
                , Theme.View.markdownToHtml caseStudy.introMarkdown
                ]
            , viewMaybeImage caseStudy.maybeIntroImage
            ]
        , div []
            [ div []
                [ h2 [] [ text (t WhatWeDidHeading) ]
                , Theme.View.markdownToHtml caseStudy.whatWeDidMarkdown
                ]
            , viewMaybeImage caseStudy.maybeWhatWeDidImage
            ]
        , div []
            [ div []
                [ h2 [] [ text (t ResultsHeading) ]
                , Theme.View.markdownToHtml caseStudy.resultsMarkdown
                ]
            , viewMaybeQuote caseStudy.maybeQuote
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

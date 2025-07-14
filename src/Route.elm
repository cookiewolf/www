module Route exposing (Route(..), fromSlug, fromUrl, toString)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Url
import Url.Builder
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Index
    | AboutUs
    | CaseStudy String


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    url
        |> Parser.parse routeParser


fromSlug : List String -> Maybe Route
fromSlug slug =
    let
        maybeUrl : Maybe Url.Url
        maybeUrl =
            Url.Builder.absolute slug []
                |> Url.fromString

        aUrl =
            Url.Builder.absolute slug []

        _ =
            Debug.log "MAYBE" maybeUrl
    in
    case maybeUrl of
        Just url ->
            fromUrl url

        Nothing ->
            Just Index


toString : Route -> String
toString route =
    case route of
        Index ->
            "/"

        AboutUs ->
            t AboutUsSlug

        CaseStudy slug ->
            "/" ++ t CaseStudySlug ++ "/" ++ slug


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Index top
        , map AboutUs (s (t AboutUsSlug))
        , map CaseStudy (s (t CaseStudySlug) </> string)
        ]

module Route exposing (Route(..), fromUrl, toString)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Url
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Index
    | AboutUs
    | CaseStudy String


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    url
        |> Parser.parse routeParser


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

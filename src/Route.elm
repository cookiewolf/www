module Route exposing (Route(..), fromUrl, toString)

import Url
import Url.Parser as Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Index


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    url
        |> Parser.parse routeParser


toString : Route -> String
toString route =
    case route of
        Index ->
            "/"


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Index top
        ]

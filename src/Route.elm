module Route exposing (Route(..), fromUrl)

import Url
import Url.Parser as Parser exposing (Parser, map, oneOf, top)


type Route
    = Index


fromUrl : Url.Url -> Maybe Route
fromUrl url =
    url
        |> Parser.parse routeParser


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Index top
        ]

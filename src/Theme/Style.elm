module Theme.Style exposing (blue, globalStyles, withMediaTablet)

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, global, typeSelector)
import Css.Media as Media exposing (only, screen, withMedia)
import Html.Styled exposing (Html)



-- Brand colours


white : Color
white =
    hex "EDF7F6"


brown : { light : Color, dark : Color }
brown =
    { light = hex "DED6D1", dark = hex "483b33" }


blue : { light : Color, dark : Color }
blue =
    { light = hex "2660A4", dark = hex "0D1B3E" }


orange : Color
orange =
    hex "F19953"



-- Breakpoints


maxMobile : Float
maxMobile =
    576


withMediaTablet : List Style -> Style
withMediaTablet =
    withMedia [ only screen [ Media.minWidth (px maxMobile) ] ]


{-| Injects a <style> tag into the body, and can target element or
class selectors anywhere, including outside the Elm app.
-}
globalStyles : Html msg
globalStyles =
    global
        [ typeSelector "body"
            [ backgroundColor white
            , color brown.dark
            , fontFamilies [ "sono", sansSerif.value ]
            , fontWeight (int 400)
            ]
        , typeSelector "h1"
            [ color blue.light
            , fontFamilies
                [ "Chau Philomene One", sansSerif.value ]
            , fontSize (rem 3)
            ]
        , typeSelector "h2"
            [ color blue.light
            , fontFamilies
                [ "Chau Philomene One", sansSerif.value ]
            , fontSize (rem 2.2)
            , paddingTop (rem 2)
            ]
        , typeSelector "h3"
            [ --color blue
              fontSize (rem 1.8)
            ]
        , typeSelector "h4"
            [--color blue
            ]
        , typeSelector "a"
            [ borderBottom3 (px 2) solid orange
            , color blue.dark
            , textDecoration none
            , hover
                [ color blue.light
                , fontWeight (int 700)
                ]
            ]
        , typeSelector "b"
            [ fontWeight (int 700)
            ]
        , typeSelector "p"
            [ adjacentSiblings
                [ typeSelector "p"
                    [ marginTop (rem 1)
                    ]
                ]
            ]
        , typeSelector "blockquote"
            [ adjacentSiblings
                [ typeSelector "blockquote"
                    [ marginTop (rem 1)
                    ]
                ]
            ]
        ]

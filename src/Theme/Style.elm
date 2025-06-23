module Theme.Style exposing (black, globalStyles, green, visuallyHiddenStyles, white, withMediaTablet)

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, global, typeSelector)
import Css.Media as Media exposing (only, screen, withMedia)
import Html.Styled exposing (Html)



-- Brand colours


black : Color
black =
    hex "000000"


white : Color
white =
    hex "FFFFFF"


green : { light : Color, mid : Color, dark : Color }
green =
    { light = hex "E6F6F0", mid = hex "8EBFAD", dark = hex "0F3729" }


pink : { light : Color, mid : Color, dark : Color }
pink =
    { light = hex "FFF0FD", mid = hex "EEC5E8", dark = hex "AF1495" }



-- Utilities


visuallyHiddenStyles : Style
visuallyHiddenStyles =
    batch
        [ height (px 1)
        , overflow hidden
        , position absolute
        , whiteSpace noWrap
        , width (px 1)
        ]



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
            , color green.dark
            , fontFamilies [ "Poppins", sansSerif.value ]
            ]
        , typeSelector "a"
            [ borderBottom3 (px 1.5) dotted pink.dark
            , color pink.dark
            , textDecoration none
            , hover
                [ borderBottom3 (px 2) dotted pink.dark
                , color pink.dark
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

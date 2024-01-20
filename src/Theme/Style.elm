module Theme.Style exposing (blue, globalStyles, gridStyle, maxMobile, oneColumn, threeColumn, twoColumn, verticalSpacing, white, withMediaLargeDevice, withMediaTablet)

import Css exposing (..)
import Css.Global exposing (adjacentSiblings, global, typeSelector)
import Css.Media as Media exposing (minWidth, only, screen, withMedia)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css, id)



-- Brand colours


white : Color
white =
    hex "EDF7F6"


brown : { light : Color, dark : Color }
brown =
    { light = hex "DED6D1", dark = hex "483b33" }


pink : Color
pink =
    hex "EEC6CA"


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


maxTablet : Float
maxTablet =
    769


maxLargeDevice : Float
maxLargeDevice =
    992


withMediaLargeDevice : List Style -> Style
withMediaLargeDevice =
    withMedia [ only screen [ Media.minWidth (px maxLargeDevice) ] ]


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


gridStyle : Style
gridStyle =
    batch
        [ displayFlex
        , flexWrap wrap
        , alignItems start
        ]


{-| A flex row item width for a single column layout
oneColumn : Css.CalculatedLength (not exposed by <https://github.com/rtfeldman/elm-css/pull/519>)
-}
oneColumn =
    calc (pct 100) minus (rem 2)


{-| A flex row item width for a double column layout
twoColumn : Css.CalculatedLength
-}
twoColumn =
    calc (pct 50) minus (rem 2)


{-| A flex row item width for a triple column layout
threeColumn : Css.CalculatedLength
-}
threeColumn =
    calc (pct 33.33) minus (rem 2)


{-| A div with known vertical margin
-}
verticalSpacing : Float -> Html msg
verticalSpacing num =
    div [ css [ margin2 (rem num) zero ] ] []

module Theme.Style exposing (black, fuchsia, globalStyles, green, pink, visuallyHiddenStyles, white, withMediaTablet)

import Css exposing (..)
import Css.Global exposing (a, adjacentSiblings, children, class, descendants, footer, global, typeSelector)
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


fuchsia : Color
fuchsia =
    hex "AF1495"



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
                [ backgroundColor pink.light
                , borderBottom3 (px 2) dotted pink.dark
                , color pink.dark
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
        , footer
            [ descendants
                [ a
                    [ borderBottom3 (px 2) dotted white
                    , color white
                    , hover
                        [ backgroundColor transparent
                        , borderBottom3 (px 2) dotted pink.mid
                        , color pink.mid
                        ]
                    ]
                ]
            ]
        , class "about-us"
            [ descendants
                [ typeSelector "p"
                    [ fontSize (rem 1.25)
                    , margin2 (rem 1) auto
                    , maxWidth (ch 80)
                    ]
                ]
            ]
        , class "profile-item"
            [ borderBottom (px 0)
            , borderRadius (px 500)
            , flexShrink zero
            , height (rem 7)
            , listStyle none
            , margin2 zero (rem 0.5)
            , position relative
            , width (rem 7)
            , pseudoClass "first-child"
                [ marginLeft auto
                ]
            , pseudoClass "last-child"
                [ marginRight auto
                ]
            ]
        , class "profile-link"
            [ hover
                [ cursor pointer
                , children
                    [ typeSelector "div"
                        [ displayFlex
                        ]
                    ]
                ]
            ]
        ]

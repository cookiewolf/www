module Page.NotFound exposing (view)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, div, h1, p, text)
import Html.Styled.Attributes exposing (css)
import Msg exposing (Msg)
import Theme.Style exposing (pink, shadow)


view : String -> Html Msg
view thing =
    div []
        [ div [ css [ titleSectionStyle ] ]
            [ h1 [] [ text <| t NotFoundTitle ]
            ]
        , div [ css [ contentAreaStyle ] ]
            [ p [] [ text <| t <| NotFoundDescription1 thing ]
            , p [] [ text <| t NotFoundDescription2 ]
            ]
        ]



-- Styles


titleSectionStyle : Style
titleSectionStyle =
    batch
        [ backgroundColor pink.light
        , boxShadow5 (px 0) (px 12) (px 20) (px -8) shadow
        , color pink.dark
        , padding2 (rem 2) zero
        , textAlign center
        ]


contentAreaStyle : Style
contentAreaStyle =
    batch
        [ padding2 (rem 2) (rem 1)
        , textAlign center
        , fontSize (em 1.5)
        ]

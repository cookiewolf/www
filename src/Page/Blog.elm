module Page.Blog exposing (blogCard, findBlogFromSlug, viewBlogCardPromo, viewBlogIndex, viewShowBlogPost)

import Array exposing (Array)
import Copy.Keys exposing (Key(..), Section(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, a, div, h1, h3, p, text)
import Html.Styled.Attributes exposing (css, href)
import Model exposing (BlogPost, Model)
import Msg exposing (Msg)
import Route
import Theme.Style exposing (green, pink, shadow, withMediaTablet)
import Theme.View exposing (contentContainer)


findBlogFromSlug : Array Model.BlogPost -> String -> Maybe Model.BlogPost
findBlogFromSlug blogPosts slug =
    blogPosts
        |> Array.filter (\p -> p.slug == slug)
        |> Array.get 0


viewBlogIndex : Model -> Html Msg
viewBlogIndex model =
    div []
        [ -- title
          div [ css [ titleBackgroundStyle ] ]
            [ div [ css [ contentContainer, titleAreaStyle ] ]
                [ h1 [ css [ titleStyle ] ] [ text <| t BlogIndexTitle ]
                ]
            ]
        , div [ css [ contentContainer, contentAreaStyle ] ]
            (model.blogPosts
                |> Array.toList
                |> List.map
                    (\post ->
                        div [ css [ blogCardStyle ] ]
                            [ blogCard post ]
                    )
            )
        ]


viewShowBlogPost : Model.BlogPost -> Html Msg
viewShowBlogPost post =
    div []
        [ -- title
          div [ css [ titleBackgroundStyle ] ]
            [ div [ css [ contentContainer, titleAreaStyle ] ]
                [ h1 [ css [ titleStyle ] ] [ text post.title ]
                , byLine post
                ]
            ]

        -- content
        , div [ css [ contentContainer, contentAreaStyle ] ]
            [ Theme.View.markdownToHtml post.content
            ]
        ]


blogCard : BlogPost -> Html Msg
blogCard post =
    div []
        [ h3 [] [ text post.title ]
        , byLine post
        , p [] [ text post.teaser ]
        , p [] [ a [ href <| Route.toString <| Route.BlogShowPost post.slug ] [ text <| t BlogCardReadMoreLink ] ]
        ]


byLine : BlogPost -> Html Msg
byLine post =
    p [ css [ byLineStyle ] ]
        [ text <| t BlogByLineBy
        , Html.Styled.em [] [ text post.author ]
        , text <| t BlogByLineOn
        , Html.Styled.em [] [ text post.publishDate ]
        ]


capArrayLength : Int -> Array v -> Array v
capArrayLength max array =
    if Array.length array > max then
        Array.slice 0 max array

    else
        array


viewBlogCardPromo : Array BlogPost -> Html Msg
viewBlogCardPromo blogPosts =
    -- as seen on the homepage
    blogPosts
        |> capArrayLength 3
        |> Array.toList
        |> List.map blogCard
        |> div [ css [ blogCardPromoAreaStyle ] ]



-- Styles


titleBackgroundStyle : Style
titleBackgroundStyle =
    batch
        [ backgroundColor pink.light
        , boxShadow4 (px 0) (px 0) (px 20) shadow
        , withMediaTablet
            [ padding2 (rem 2) (rem 1)
            ]
        ]


titleAreaStyle : Style
titleAreaStyle =
    batch
        [ padding2 (rem 2) (rem 1)
        ]


titleStyle : Style
titleStyle =
    batch
        [ fontSize (rem 2.5)
        , fontWeight bold
        , lineHeight (rem 3)
        , withMediaTablet
            [ fontSize (rem 3.75)
            , lineHeight (rem 4.5)
            ]
        ]


contentAreaStyle : Style
contentAreaStyle =
    batch
        [ padding2 (rem 2) (rem 1)
        ]


blogCardStyle : Style
blogCardStyle =
    batch
        [ paddingBottom (rem 2)
        ]


blogCardPromoAreaStyle : Style
blogCardPromoAreaStyle =
    batch
        [ displayFlex
        , maxWidth (px 1000)
        , margin auto
        , property "gap" "2em"
        , justifyContent center
        ]


byLineStyle : Style
byLineStyle =
    batch
        [ fontSize (Css.em 0.9)
        , color green.dark
        ]

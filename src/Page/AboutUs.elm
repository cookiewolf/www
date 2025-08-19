module Page.AboutUs exposing (view)

import Copy.AboutUs
import Copy.Keys exposing (Key(..), Section(..))
import Copy.Text exposing (t)
import Css exposing (..)
import Html.Styled exposing (Html, button, div, h1, h2, h3, hr, img, section, text)
import Html.Styled.Attributes exposing (alt, attribute, css, id, src, type_)
import Html.Styled.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)
import Set
import Theme.Style exposing (green, pink, shadow, withMediaTablet)
import Theme.View exposing (contentContainer, generateId)


view : Model -> Html Msg
view model =
    div []
        [ div [ css [ titleSectionStyle ] ]
            [ h1 [] [ text (t AboutUsTitle) ]
            ]
        , div [] (viewProfileSections model)
        ]


viewProfileSection : Model -> Section -> List Model.ProfileInfo -> Html Msg
viewProfileSection model profileSection profiles =
    div []
        [ div [ css [ areaTitleStyle ] ]
            [ h2 [] [ text (t (AboutUsSection profileSection)) ]
            ]
        , section [] (viewProfiles model profiles)
        ]


viewProfile : Model -> Model.ProfileInfo -> List (Html Msg)
viewProfile model profile =
    let
        sectionId : String
        sectionId =
            generateId profile.name

        isSmallScreen : Bool
        isSmallScreen =
            Tuple.second model.viewportHeightWidth < Theme.Style.maxMobile
    in
    [ if isSmallScreen then
        div []
            [ h3 [ id sectionId ]
                [ button
                    [ id ("header-" ++ sectionId)
                    , if Set.member sectionId model.openSections then
                        attribute "aria-expanded" "true"

                      else
                        attribute "aria-expanded" "false"
                    , attribute "aria-controls" ("content-" ++ sectionId)
                    , onClick (Msg.SectionToggled sectionId)
                    , type_ "button"
                    , css [ buttonStyle ]
                    ]
                    [ div [ css [ profileLayoutStyle ] ]
                        [ img [ src profile.imagePath, css [ iconStyle ], alt "" ] []
                        , div []
                            [ div [ css [ nameStyle ] ] [ text profile.name ]
                            , div [ css [ titleStyle ] ] [ text profile.role ]
                            ]
                        , img
                            [ src "/arrow.svg"
                            , css
                                [ if Set.member sectionId model.openSections then
                                    openArrowStyle

                                  else
                                    arrowStyle
                                ]
                            , alt ""
                            ]
                            []
                        ]
                    ]
                ]
            , viewProfileInfoSection isSmallScreen model profile
            , hr [ css [ hrStyle ] ] []
            ]

      else
        div []
            [ div [ css [ profileLayoutStyle ] ]
                [ img [ src profile.imagePath, css [ iconStyle ], alt "" ] []
                , div []
                    [ h3 [ id sectionId ] [ text profile.name ]
                    , div [ css [ titleStyle ] ] [ text profile.role ]
                    , viewProfileInfoSection isSmallScreen model profile
                    ]
                ]
            , hr [ css [ hrStyle ] ] []
            ]
    ]


viewProfileInfoSection : Bool -> Model -> Model.ProfileInfo -> Html Msg
viewProfileInfoSection isSmallScreen model profile =
    let
        sectionId : String
        sectionId =
            generateId profile.name

        collapseAttributes : List (Html.Styled.Attribute Msg)
        collapseAttributes =
            if isSmallScreen then
                [ attribute "aria-labelledby" ("header-" ++ sectionId)
                , if Set.member sectionId model.openSections then
                    css []

                  else
                    css [ Theme.Style.visuallyHiddenStyles ]
                ]

            else
                []
    in
    div
        (id ("content-" ++ sectionId) :: collapseAttributes)
        [ div [ css [ contentContainer ] ]
            [ div [ css [ profileInfoStyle ] ] [ Theme.View.markdownToHtml profile.bioMarkdown ]
            , div [ css [ profileInfoStyle ] ] [ Theme.View.markdownToHtml (t AboutUsProfileProjectsLabel ++ profile.projectsMarkdown) ]
            ]
        ]


viewProfileSections : Model -> List (Html Msg)
viewProfileSections model =
    List.map
        (\profileSection ->
            List.filter
                (\profile ->
                    profile.section == profileSection
                )
                Copy.AboutUs.profiles
                |> viewProfileSection model profileSection
        )
        [ Business, ContentAndDesign, DigitalDevelopment ]


viewProfiles : Model -> List Model.ProfileInfo -> List (Html Msg)
viewProfiles model profiles =
    List.concat
        (List.map
            (\profile ->
                viewProfile model profile
            )
            profiles
        )



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


areaTitleStyle : Style
areaTitleStyle =
    batch
        [ boxShadow5 (px 0) (px 12) (px 20) (px -8) shadow
        , padding2 (rem 2) zero
        , textAlign center
        ]


profileLayoutStyle : Style
profileLayoutStyle =
    batch
        [ alignItems center
        , displayFlex
        , margin auto
        , maxWidth (px 1000)
        , padding2 (rem 1) (rem 1)
        , property "gap" "1rem"
        , withMediaTablet
            [ alignItems flexStart
            , padding2 (rem 3) (rem 1)
            , property "gap" "2rem"
            ]
        ]


buttonStyle : Style
buttonStyle =
    batch
        [ backgroundColor transparent
        , border (px 0)
        , width (pct 100)
        ]


iconStyle : Style
iconStyle =
    batch
        [ borderRadius (px 500)
        , flexShrink zero
        , height (rem 5)
        , property "object-fit" "cover"
        , width (rem 5)
        , withMediaTablet
            [ height (rem 15)
            , width (rem 15)
            ]
        ]


nameStyle : Style
nameStyle =
    batch
        [ color green.dark
        , fontSize (rem 1.25)
        , fontWeight (int 700)
        , textAlign left
        ]


titleStyle : Style
titleStyle =
    batch
        [ color pink.dark
        , fontSize (rem 1.25)
        , fontWeight (int 400)
        , textAlign left
        ]


arrowStyle : Style
arrowStyle =
    batch
        [ width (rem 2) ]


openArrowStyle : Style
openArrowStyle =
    batch
        [ transform (rotate (deg 90))
        , width (rem 2)
        ]


hrStyle : Style
hrStyle =
    batch
        [ border3 (px 1) dashed pink.dark
        , margin (px 0)
        ]


profileInfoStyle : Style
profileInfoStyle =
    batch
        [ margin2 (rem 1) (rem 0)
        , padding2 (rem 0) (rem 1)
        , withMediaTablet
            [ marginTop (rem 1)
            , padding2 (rem 0) (rem 0)
            ]
        ]

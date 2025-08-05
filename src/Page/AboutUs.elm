module Page.AboutUs exposing (view)

import Copy.AboutUs
import Copy.Keys exposing (Key(..), Section(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, button, div, h1, h2, h3, h4, section, text)
import Html.Styled.Attributes exposing (attribute, css, id, type_)
import Html.Styled.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)
import Set
import Theme.Style
import Theme.View exposing (generateId)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (t AboutUsTitle) ]
        , div [] (viewProfileSections model)
        ]


viewProfileSection : Model -> Section -> List Model.ProfileInfo -> Html Msg
viewProfileSection model profileSection profiles =
    div []
        [ h2 [] [ text (t (AboutUsSection profileSection)) ]
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
        h3 [ id sectionId ]
            [ button
                [ id ("header-" ++ sectionId)
                , if Set.member sectionId model.openSections then
                    attribute "aria-expanded" "true"

                  else
                    attribute "aria-expanded" "false"
                , attribute "aria-controls" ("content-" ++ sectionId)
                , onClick (Msg.SectionToggled sectionId)
                , type_ "button"
                ]
                [ text profile.name
                ]
            ]

      else
        h3 [ id sectionId ] [ text profile.name ]
    , viewProfileInfoSection isSmallScreen model profile
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
    section
        (id ("content-" ++ sectionId) :: collapseAttributes)
        [ h4 [] [ text profile.role ]
        , div [] [ Theme.View.markdownToHtml profile.bioMarkdown ]
        , div [] [ Theme.View.markdownToHtml (t AboutUsProfileProjectsLabel ++ profile.projectsMarkdown) ]
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

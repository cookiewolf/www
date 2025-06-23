module Page.AboutUs exposing (view)

import Copy.AboutUs
import Copy.Keys exposing (Key(..), Section(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, button, div, h1, h2, h3, h4, section, text)
import Html.Styled.Attributes exposing (attribute, css, id)
import Html.Styled.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (Msg)
import Set
import Theme.Style
import Theme.View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (t AboutUsTitle) ]
        , div [] (viewProfileSections model)
        ]


viewProfileSection : Model -> Section -> List Model.ProfileInfo -> Html Msg
viewProfileSection model profileSection profiles =
    div []
        [ h2 []
            [ button
                [ id (headerIdFromSection profileSection)
                , if Set.member (slugFromSection profileSection) model.openSections then
                    attribute "aria-expanded" "true"

                  else
                    attribute "aria-expanded" "false"
                , attribute "aria-controls" (contentIdFromSection profileSection)
                , onClick (Msg.SectionToggled (slugFromSection profileSection))
                ]
                [ text (t (AboutUsSection profileSection))
                ]
            ]
        , section
            [ id (contentIdFromSection profileSection)
            , attribute "aria-labelledby" (headerIdFromSection profileSection)
            , if Set.member (slugFromSection profileSection) model.openSections then
                css [ Theme.Style.visuallyHiddenStyles ]

              else
                css []
            ]
            (viewProfiles profiles)
        ]


viewProfile : Model.ProfileInfo -> List (Html Msg)
viewProfile profile =
    [ h3 [] [ text profile.name ]
    , h4 [] [ text profile.role ]
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


viewProfiles : List Model.ProfileInfo -> List (Html Msg)
viewProfiles profiles =
    List.concat
        (List.map
            (\profile ->
                viewProfile profile
            )
            profiles
        )


headerIdFromSection : Section -> String
headerIdFromSection profileSection =
    "header-"
        ++ slugFromSection profileSection


contentIdFromSection : Section -> String
contentIdFromSection profileSection =
    "content-"
        ++ slugFromSection profileSection


slugFromSection : Section -> String
slugFromSection profileSection =
    slugify (t (AboutUsSection profileSection))


slugify : String -> String
slugify rawString =
    String.toLower rawString
        |> String.replace " " "-"

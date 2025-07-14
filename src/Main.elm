module Main exposing (main)

import Browser
import Browser.Navigation
import Copy.CaseStudy
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, toUnstyled)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Page.AboutUs
import Page.CaseStudy
import Page.Index
import Route exposing (Route(..))
import Set
import Theme.View
import Url


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = viewDocument
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


init : Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        maybeRoute : Maybe Route
        maybeRoute =
            Route.fromUrl url
    in
    ( { key = key
      , page = Maybe.withDefault Index maybeRoute
      , openSections = Set.empty
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SectionToggled sectionSlug ->
            let
                newOpenSections =
                    if Set.member sectionSlug model.openSections then
                        Set.remove sectionSlug model.openSections

                    else
                        Set.insert sectionSlug model.openSections
            in
            ( { model | openSections = newOpenSections }, Cmd.none )

        UrlChanged url ->
            let
                newRoute : Route
                newRoute =
                    -- If not a valid route, go to index
                    -- could 404 instead depends on desired behaviour
                    Maybe.withDefault Index (Route.fromUrl url)
            in
            ( { model | page = newRoute }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Browser.Navigation.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Browser.Navigation.load href
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


viewDocument : Model -> Browser.Document Msg
viewDocument model =
    { title = t SiteTitle, body = [ toUnstyled (view model) ] }


view : Model -> Html Msg
view model =
    case model.page of
        Index ->
            Theme.View.viewPageWrapper (t SiteTitle) (Page.Index.view model)

        AboutUs ->
            Theme.View.viewPageWrapper (t AboutUsTitle) (Page.AboutUs.view model)

        CaseStudy slug ->
            let
                caseStudy : Model.CaseStudy
                caseStudy =
                    Copy.CaseStudy.caseStudyIdFromSlug slug
                        |> Copy.CaseStudy.caseStudyFromId

                maybeContent : Maybe Model.CaseStudyContent
                maybeContent =
                    caseStudy.maybePageContent
            in
            case maybeContent of
                Just content ->
                    Theme.View.viewPageWrapper caseStudy.title (Page.CaseStudy.view caseStudy.title content)

                Nothing ->
                    -- Replace with global 404 ?
                    Theme.View.viewPageWrapper (t SiteTitle) (Page.Index.view model)

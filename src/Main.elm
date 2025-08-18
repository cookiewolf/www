module Main exposing (main)

import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Copy.CaseStudy
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, toUnstyled)
import MetaTags
import Model exposing (Model)
import Msg exposing (Msg(..))
import Page.AboutUs
import Page.CaseStudy
import Page.Index
import Route exposing (Route(..))
import Set
import Task
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
        route : Route
        route =
            Maybe.withDefault Index <| Route.fromUrl url

        openSections : Set.Set String
        openSections =
            case url.fragment of
                Just aFragment ->
                    Set.fromList [ aFragment ]

                Nothing ->
                    Set.empty
    in
    ( { key = key
      , page = route
      , viewportHeightWidth = ( 800, 800 )
      , openSections = openSections
      }
    , Cmd.batch
        [ MetaTags.setMetadata <| MetaTags.metaForPage route
        , Task.perform GotViewport Browser.Dom.getViewport
        ]
    )


possiblyScrollToTop : Set.Set String -> Cmd Msg
possiblyScrollToTop fragments =
    if Set.isEmpty fragments then
        -- scroll to top
        Task.perform (\_ -> Msg.NoOp) (Browser.Dom.setViewport 0 0)

    else
        Cmd.none


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

        GotViewport viewport ->
            ( { model
                | viewportHeightWidth =
                    Maybe.withDefault model.viewportHeightWidth (Just ( viewport.viewport.height, viewport.viewport.width ))
              }
            , Cmd.none
            )

        OnResize newViewportHeightWidth ->
            ( { model | viewportHeightWidth = newViewportHeightWidth }
            , Cmd.none
            )

        UrlChanged url ->
            let
                newRoute : Route
                newRoute =
                    -- If not a valid route, go to index
                    -- could 404 instead depends on desired behaviour
                    Maybe.withDefault Index (Route.fromUrl url)

                openSections : Set.Set String
                openSections =
                    case url.fragment of
                        Just aFragment ->
                            Set.fromList [ aFragment ]

                        Nothing ->
                            Set.empty
            in
            ( { model | page = newRoute, openSections = openSections }
            , Cmd.batch
                [ MetaTags.setMetadata <| MetaTags.metaForPage newRoute
                , possiblyScrollToTop openSections
                ]
            )

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

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onResize
            (\newWidth newHeight ->
                OnResize ( toFloat newHeight, toFloat newWidth )
            )
        ]


viewDocument : Model -> Browser.Document Msg
viewDocument model =
    { title = MetaTags.titleForPage model.page
    , body = [ toUnstyled (view model) ]
    }


view : Model -> Html Msg
view model =
    case model.page of
        Index ->
            Theme.View.viewPageWrapper (t SiteTitle) Page.Index.view

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
                    Theme.View.viewPageWrapper (t SiteTitle) Page.Index.view

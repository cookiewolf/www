module Main exposing (main)

import Browser
import Browser.Navigation
import Copy.CaseStudy
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, toUnstyled)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Page.CaseStudy
import Page.Index
import Route exposing (Route(..))
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
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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

        CaseStudy slug ->
            let
                caseStudy =
                    Copy.CaseStudy.caseStudyIdFromSlug slug
                        |> Copy.CaseStudy.caseStudyFromId
            in
            Theme.View.viewPageWrapper caseStudy.title (Page.CaseStudy.view model caseStudy)

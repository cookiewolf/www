module Main exposing (main)

-- import Json.Decode.Field as Field

import Array exposing (Array)
import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Copy.CaseStudy
import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import Html.Styled exposing (Html, toUnstyled)
import Json.Decode as JD
import MetaTags
import Model exposing (BlogPost, Model, PageResource)
import Msg exposing (Msg(..))
import Page.AboutUs
import Page.Blog as Blog
import Page.CaseStudy
import Page.Index
import Page.NotFound
import Route exposing (Route(..))
import Set
import Task
import Theme.View
import Url


type alias Flags =
    { posts : Array BlogPost
    }


main : Program JD.Value Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = viewDocument
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }


setupResourceForPage : Array BlogPost -> Route -> PageResource
setupResourceForPage blogPosts route =
    let
        baseResource =
            Model.emptyPageResource
    in
    case route of
        Index ->
            { baseResource
                | meta = MetaTags.metaForRoot
            }

        AboutUs ->
            { baseResource
                | meta = MetaTags.metaForAboutUs
            }

        CaseStudy slug ->
            case Copy.CaseStudy.caseStudyFromSlug slug of
                Just foundCaseStudy ->
                    { baseResource
                        | caseStudy = Just foundCaseStudy
                        , meta = MetaTags.metaForCaseStudy foundCaseStudy
                    }

                Nothing ->
                    { baseResource
                        | meta = MetaTags.metaForNotFound (t CaseStudyTitle)
                    }

        BlogIndex ->
            { baseResource
                | meta = MetaTags.metaForBlogIndex
            }

        BlogShowPost slug ->
            case Blog.findBlogFromSlug blogPosts slug of
                Just blogPost ->
                    { baseResource
                        | blogPost = Just blogPost
                        , meta = MetaTags.metaForBlogShowPost blogPost
                    }

                Nothing ->
                    { baseResource
                        | meta = MetaTags.metaForNotFound (t BlogNotFoundThing)
                    }

        NotFound ->
            { baseResource
                | meta = MetaTags.metaForNotFound (t NotFoundThing)
            }


init : JD.Value -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init rawFlags url key =
    let
        route : Route
        route =
            Maybe.withDefault NotFound <| Route.fromUrl url

        openSections : Set.Set String
        openSections =
            case url.fragment of
                Just aFragment ->
                    Set.fromList [ aFragment ]

                Nothing ->
                    Set.empty

        flags =
            rawFlags
                |> JD.decodeValue flagsDecoder
                --|> Result.mapError (\err -> Debug.log "flags decode error: " err)
                |> Result.withDefault { posts = Array.empty }

        resource =
            setupResourceForPage flags.posts route
    in
    ( { key = key
      , page = route
      , viewportHeightWidth = ( 800, 800 )
      , openSections = openSections
      , blogPosts = flags.posts
      , pageResource = resource
      }
    , Cmd.batch
        [ MetaTags.setMetadata <| resource.meta
        , Task.perform GotViewport Browser.Dom.getViewport
        ]
    )


possiblyScrollToTop : Url.Url -> Cmd Msg
possiblyScrollToTop url =
    case url.fragment of
        Just _ ->
            Cmd.none

        Nothing ->
            -- scroll to top
            Task.perform (\_ -> Msg.NoOp) (Browser.Dom.setViewport 0 0)


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
                    Maybe.withDefault NotFound (Route.fromUrl url)

                openSections : Set.Set String
                openSections =
                    case url.fragment of
                        Just aFragment ->
                            Set.fromList [ aFragment ]

                        Nothing ->
                            Set.empty

                resource =
                    setupResourceForPage model.blogPosts newRoute
            in
            ( { model
                | page = newRoute
                , openSections = openSections
                , pageResource = resource
              }
            , Cmd.batch
                [ MetaTags.setMetadata <| resource.meta
                , possiblyScrollToTop url
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
    { title = model.pageResource.meta.title
    , body = [ toUnstyled (view model) ]
    }


view : Model -> Html Msg
view model =
    let
        innerPage =
            case model.page of
                Index ->
                    Page.Index.view model.blogPosts

                AboutUs ->
                    Page.AboutUs.view model

                CaseStudy _ ->
                    -- FIXME. this is jank
                    --  we know case study exists
                    --  we should move the meta data out of the embedded CaseStudy
                    --  and just pass that along
                    case model.pageResource.caseStudy of
                        Just caseStudy ->
                            caseStudy.maybePageContent
                                |> Maybe.withDefault Model.emptyCaseStudyContent
                                |> Page.CaseStudy.view caseStudy.title

                        Nothing ->
                            Page.NotFound.view (t CaseStudyTitle)

                BlogIndex ->
                    Blog.viewBlogIndex model

                BlogShowPost _ ->
                    case model.pageResource.blogPost of
                        Just post ->
                            Blog.viewShowBlogPost post

                        Nothing ->
                            Page.NotFound.view (t BlogNotFoundThing)

                NotFound ->
                    Page.NotFound.view (t NotFoundThing)
    in
    Theme.View.viewPageWrapper
        model.pageResource.meta.title
        innerPage


flagsDecoder : JD.Decoder Flags
flagsDecoder =
    let
        postDecoder =
            JD.map7 BlogPost
                (JD.field "slug" JD.string)
                (JD.field "author" JD.string)
                (JD.field "publish_date" JD.string)
                (JD.field "title" JD.string)
                (JD.field "teaser" JD.string)
                (JD.field "keywords" JD.string)
                (JD.field "content" JD.string)
    in
    JD.map Flags
        (JD.field "blog_posts" <| JD.array postDecoder)

module Msg exposing (Msg(..))

import Browser
import Browser.Dom
import Url


type Msg
    = SectionToggled String
    | GotViewport Browser.Dom.Viewport
    | OnResize ( Float, Float )
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | NoOp

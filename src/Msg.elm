module Msg exposing (Msg(..))

import Browser
import Url


type Msg
    = SectionToggled String
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest

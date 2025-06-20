module Msg exposing (Msg(..))

import Browser
import Copy.Keys
import Url


type Msg
    = SectionToggled String
    | UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest

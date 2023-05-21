module Msg exposing (Msg(..))

import Browser
import Url


type Msg
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest

module Main exposing (main)

import Browser
import Html exposing (Html, text, h1)


type alias Model =
    String


type Msg
    = NoOp


init : () -> ( Model, Cmd Msg )
init _ =
    ( "Hello world", Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    h1 []
        [text model]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }

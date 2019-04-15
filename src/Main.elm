module Main exposing (main)

import Browser
import Html exposing (Html, text)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    String


init : () -> ( Model, Cmd Msg )
init _ =
    ( "Hello", Cmd.none )


type Msg
    = Ignore


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ignore ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    text model

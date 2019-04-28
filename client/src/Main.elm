module Main exposing (main)

import Browser
import Html exposing (Html, table, td, text, th, tr)
import Http
import Json.Decode as Decode exposing (Decoder)


type alias User =
    { id : Int
    , name : String
    , email : String
    }


userDecoder : Decoder User
userDecoder =
    Decode.map3 User
        (Decode.field "id" Decode.int)
        (Decode.field "name" Decode.string)
        (Decode.field "email" Decode.string)


usersDecoder : Decoder (List User)
usersDecoder =
    Decode.list userDecoder


type alias Model =
    List User


type Msg
    = ReceiveUsers (Result Http.Error (List User))


init : () -> ( Model, Cmd Msg )
init _ =
    ( []
    , Http.get
        { url = "/api/users"
        , expect = Http.expectJson ReceiveUsers usersDecoder
        }
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveUsers (Ok users) ->
            ( users, Cmd.none )

        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view users =
    table []
        (tr []
            [ th []
                [ text "id" ]
            , th []
                [ text "name" ]
            , th []
                [ text "email" ]
            ]
            :: List.map viewUser users
        )


viewUser : User -> Html Msg
viewUser { id, name, email } =
    tr []
        [ td []
            [ text (String.fromInt id) ]
        , td []
            [ text name ]
        , td []
            [ text email ]
        ]


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = always Sub.none
        , update = update
        , view = view
        }

module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Json.Decode
import Set exposing (Set)
import Http


---- MODEL ----


type alias Model =
    { guesses : Set String
    , gameState : GameState
    }


type GameState
    = Loading
    | Running String
    | Won
    | Lost
    | Error String


init : ( Model, Cmd Msg )
init =
    ( { guesses = Set.empty
      , gameState = Loading
      }
    , fetchWord
    )


fetchWord : Cmd Msg
fetchWord =
    Http.send NewPhrase <|
        Http.get "https://snapdragon-fox.glitch.me/word" wordDecoder


wordDecoder : Json.Decode.Decoder String
wordDecoder =
    Json.Decode.field "word" Json.Decode.string



---- UPDATE ----


type Msg
    = Guess String
    | Restart
    | NewPhrase (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Guess letter ->
            ( { model | guesses = Set.insert letter model.guesses }, Cmd.none )

        Restart ->
            ( { model | guesses = Set.empty, gameState = Loading }, fetchWord )

        NewPhrase (Ok phrase) ->
            ( { model | gameState = Running phrase }, Cmd.none )

        NewPhrase (Err error) ->
            ( { model | gameState = Error <| toString error }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        phraseHtml =
            case model.gameState of
                Loading ->
                    span [] [ text "Loading" ]

                Running phrase ->
                    phrase
                        |> String.split ""
                        |> List.map
                            (\letter ->
                                if letter == " " then
                                    " "
                                else if Set.member letter model.guesses then
                                    letter
                                else
                                    "_"
                            )
                        |> List.map
                            (\entry ->
                                span [] [ text entry ]
                            )
                        |> div []

                Won ->
                    span [] [ text "Congrats!" ]

                Lost ->
                    span [] [ text "Ooooooops" ]

                Error error ->
                    span [] [ text error ]

        failuresHtml =
            case model.gameState of
                Running phrase ->
                    model.guesses
                        |> Set.toList
                        |> List.filter
                            (\letter ->
                                not <| String.contains letter phrase
                            )
                        |> List.map
                            (\letter ->
                                span [] [ text letter ]
                            )
                        |> div []

                _ ->
                    text ""

        buttonsHtml =
            "abcdefghijklmnopqrstuvwxyz"
                |> String.split ""
                |> List.map
                    (\letter ->
                        button [ onClick <| Guess letter ] [ text letter ]
                    )
                |> div []
    in
        div []
            [ phraseHtml
            , buttonsHtml
            , failuresHtml
            , div []
                [ button [ onClick Restart ] [ text "Restart" ]
                ]
            ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char
import String
import List

main : Program Never Model Msg
main = Html.program {init = init, view = view, update = update, subscriptions = subscriptions}

type alias Model =
 {
    name : String,
    password : String,
    passwordAgain : String
 }

init : (Model, Cmd Msg)
init = (Model "" "" "", Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

type Msg = Name String | Password String | PasswordAgain String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Name name -> ({ model | name = name},Cmd.none)
        Password pass -> ({model | password = pass},Cmd.none)
        PasswordAgain pass -> ({model | passwordAgain = pass},Cmd.none)

view : Model -> Html Msg
view model =
    div []
        [
            input[type_ "text", placeholder "Name", onInput Name][],
            input[type_ "password", placeholder "Password", onInput Password][],
            input[type_ "password", placeholder "Confirm", onInput PasswordAgain][],
            viewValidate model
        ]

viewValidate : Model -> Html Msg
viewValidate model =
    let list = checkMinLength model :: checkPassword model :: checkUpper model :: checkLower model :: checkDigit model :: []
        wrongList = List.filter (\(x,y) -> not x) list
    in
    if List.length wrongList == 0 then
        div [] [button[][text "Submit"]]
    else
        div [] (List.map showError wrongList )

showError : (Bool,String) -> Html Msg
showError (_,error) =
    div [style[("color","red")]] [text error]

checkPassword : Model -> (Bool, String)
checkPassword model =
    if model.password == model.passwordAgain then
        (True,"")
    else
        (False,"Passwords do not match")

checkMinLength : Model -> (Bool,String)
checkMinLength model =
    if String.length model.password > 7 then
        (True,"OK")
    else
        (False,"Password must have a minimum length of 8 characters")

checkUpper : Model -> (Bool,String)
checkUpper model =
    let isUp = String.any Char.isUpper model.password
    in
    if isUp then
        (True,"")
    else
        (False,"The password must contain an upper letter")

checkLower : Model -> (Bool,String)
checkLower model =
    let isDown = String.any Char.isLower model.password
    in
    if isDown then
        (True,"")
    else
        (False,"The password must contain a lower letter")

checkDigit : Model -> (Bool,String)
checkDigit model =
    let isDig = String.any Char.isDigit model.password
    in
    if isDig then
        (True,"")
    else
        (False,"The password must contain a digit")

module Slides exposing (Message, Model, slides, subscriptions, update, view)

import Exercises as Exercises exposing (Section(..))
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import SharedType exposing (CustomSlide, Message(..), Model)
import SliceShow.Content exposing (..)
import SliceShow.Slide exposing (..)
import Time


{-| The name(s) of people facilitating the session
-}
facilitatedBy : String
facilitatedBy =
    -- e.g. "Katja & Dan"
    "Katja (with help from Dan, Felienne, Nick and Rupert)"


{-| A link to the code in annotation tool
To generate a link, go to <https://annotate.codereading.club>
-}
annotationLink : String
annotationLink =
    -- e.g. "https://annotate.code-reading.org/#/file/LYewXglgNlCGD0BzApgYwNYgLQBNkDd4AjKEI+HARgAYB2I1ADlmVh1ScoDYjZGBWVEQBMlVJVhdYE2OJwAWZADMAnEuIAnEAHcAzsg3xQOAK5Rku+ABEIu1CHwGAngDoAVruBA"
    ""


{-| A link for a shared workspace for your session
e.g. miro, jamboard
-}
groupWorkspaceLink : String
groupWorkspaceLink =
    -- e.g. "https://miro.com/welcomeonboard/dlVRdlJVSk5EVlFBazdBV0hUdHc1aVZ6SDJVVHlhTEdZcGhQdERIUXF5WHhJa29FQUhWMHdnNHk2RXhscHBKZnwzMDc0NDU3MzQ5MTgyMDYwNDgy?invite_link_id=406316329300"
    ""


{-| A link to download pdf of your code
Leave empty if you don't need downloadable pdf
-}
pdfLink : String
pdfLink =
    ""


{-| What the code is
-}
codeDescription : String
codeDescription =
    -- e.g. "Firefox browser module Discovery.jsm"
    ""


{-| A link to the code in repo
-}
codeLink : String
codeLink =
    -- e.g. "https://github.com/mozilla/gecko-dev/blob/d107bc8aeadcc816ba85cb21c1a6a1aac1d4ef9f/browser/modules/Discovery.jsm"
    ""


{-| The list of slides to use for this session
-}
slides : List CustomSlide
slides =
    ----
    -- Choose one list of sections from below
    -- (newGroupSlides, firstLookSlides, secondLookSlides)
    -- or make your own
    ----
    [ WorkshopIntro
        { facilitatedBy = facilitatedBy
        , groupWorkspaceLink = groupWorkspaceLink
        , annotationLink = annotationLink
        , pdfLink = pdfLink
        }
    , WhyCodeReading
    , FirstGlance
    , WhatAreWeThinking
    , Syntax
    , Break
    , RandomLine
    , ListNames
    , AnnotateStructure { annotationLink = annotationLink, pdfLink = "" }
    , ImportantLines
    , DecisionSummary
    , SessionEnd
        { codeDescription = codeDescription
        , codeLink = codeLink
        }
    ]
        |> List.map (\section -> Exercises.slideContent section)
        |> List.concat
        |> List.map Exercises.paddedSlide



----
--
-- Ready made slide sets
--
----


{-| Example list of sections for a first session with a new group
-}
newGroupSlides : List Section
newGroupSlides =
    [ SessionStartFirstClub
        { facilitatedBy = facilitatedBy
        , groupWorkspaceLink = groupWorkspaceLink
        , annotationLink = annotationLink
        , pdfLink = pdfLink
        }
    , FirstGlance
    , WhyDoingThis
    , SecondThoughts
    , Syntax
    , ListNames
    , RandomLine
    , AnnotateStructure { annotationLink = annotationLink, pdfLink = "" }
    , ImportantLines
    , Summarise
    , Reflect
    , Feedback
    , SessionEnd
        { codeDescription = codeDescription
        , codeLink = codeLink
        }
    ]


{-| Example list of sections for a first session on a piece of code
with an established group
-}
firstLookSlides : List Section
firstLookSlides =
    [ SessionStart
        { facilitatedBy = facilitatedBy
        , groupWorkspaceLink = groupWorkspaceLink
        , annotationLink = annotationLink
        , pdfLink = pdfLink
        }
    , FirstGlance
    , SecondThoughts
    , Syntax
    , AnnotateStructure { annotationLink = annotationLink, pdfLink = "" }
    , ImportantLines
    , Summarise
    , SessionEnd
        { codeDescription = codeDescription
        , codeLink = codeLink
        }
    ]


{-| A list of line numbers identified by group as important in first session
-}
importantLinesFromPrevious : List Int
importantLinesFromPrevious =
    [ 13, 34, 59, 89 ]


{-| Example list of sections for a second session on a piece of code
with an established group
-}
secondLookSlides : List Section
secondLookSlides =
    [ SessionStart
        { facilitatedBy = facilitatedBy
        , groupWorkspaceLink = groupWorkspaceLink
        , annotationLink = annotationLink
        , pdfLink = pdfLink
        }
    , RandomLine
    , SecondThoughts
    , RecapStructure importantLinesFromPrevious
    , DecisionsMade
    , DecisionsConsequences
    , DecisionsWhy
    , SessionEnd
        { codeDescription = codeDescription
        , codeLink = codeLink
        }
    ]



----
-- Model, Update, View & Subscription for slide structure & timer
----


type alias Message =
    SharedType.Message


type alias Model =
    SharedType.Model


{-| Update function for the custom content (timer)
-}
update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Tick _ ->
            ( { model | displayTime = model.displayTime - 1000 }, Cmd.none )

        AddStartMinute ->
            ( { model | startTime = model.startTime + 60 }, Cmd.none )

        StartStopPressed state ->
            ( { model
                | displayTime = model.startTime * 1000
                , timerStarted = not state
              }
            , Cmd.none
            )


{-| View function for the custom content that shows time remaining
-}
view : Model -> Html Message
view model =
    div
        [ class "stopwatch" ]
        [ span []
            [ if
                model.startTime
                    /= 0
                    && model.timerStarted
              then
                if model.displayTime > 0 then
                    text
                        ((round model.displayTime // 1000 |> String.fromInt)
                            ++ " seconds"
                        )

                else
                    text "Time's up"

              else
                button
                    [ onClick AddStartMinute ]
                    [ text (String.fromFloat model.startTime) ]
            ]
        , button [ onClick (StartStopPressed model.timerStarted) ]
            [ if model.timerStarted then
                text ""

              else
                text "Go !"
            ]
        ]


{-| Inputs for the custom content (timer)
-}
subscriptions : Model -> Sub Message
subscriptions model =
    if model.timerStarted then
        Time.every 1000 Tick

    else
        Sub.none

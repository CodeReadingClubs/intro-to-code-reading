module SharedType exposing (..)

import SliceShow.Content
import SliceShow.Slide
import Time


type alias Model =
    { displayTime : Float
    , startTime : Float
    , timerStarted : Bool
    }


type Message
    = Tick Time.Posix
    | AddStartMinute
    | StartStopPressed Bool


type alias CustomSlide =
    SliceShow.Slide.Slide Model Message


type alias CustomContent =
    SliceShow.Content.Content Model Message



-- Slide config types


type alias ExerciseIntro =
    { title : String
    , body : String
    }


type alias StartInfo =
    { facilitatedBy : String
    , groupWorkspaceLink : String
    , annotationLink : String
    , pdfLink : String
    }


type alias EndInfo =
    { codeDescription : String
    , codeLink : String
    }


type alias AnnotateInfo =
    { annotationLink : String
    , pdfLink : String
    }

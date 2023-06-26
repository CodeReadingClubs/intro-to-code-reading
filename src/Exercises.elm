module Exercises exposing (..)

import Html exposing (a, br, div, h1, h2, h3, hr, img, li, p, span, text, ul)
import Html.Attributes exposing (class, href, src, style)
import Markdown
import SharedType exposing (AnnotateInfo, CustomContent, CustomSlide, EndInfo, ExerciseIntro, StartInfo)
import SliceShow.Content exposing (..)
import SliceShow.Slide exposing (..)


glanceAndAnnotateAnnotate =
    "https://annotate.codereading.club/#/file/M4Sw5gdghgNlAO8D0Blc0YFoQHkVICMYB7AwgNgA4ATSqAZgGNKBGAFgHYAzAUwICYC5AJw8Obfiyjl+AVnIAGSozZsCwyuVn9U6WEmAAnRkgCyxajxjAkABQAWxCDwByAVwC2BHoYBqsEGooABdiQwA6YAB3EC5go"


glanceAndAnnotatePdf =
    "/colour.pdf"


namesAnnotate =
    "https://annotate.codereading.club/#/file/JYEwtAyg9gZgLgdwIYCcCmB6AIgeRwWQwCMAbKIjAdmoGYBWAYxphgAZqAmANlYE41eDABwgO-GgzQckRACwcWdWaNYUSwAHYBXAB4goUALZgAjADoTrDAAcA+nDQk01uGYZA"


namesPdf =
    "/naming.pdf"


randomAnnotate =
    "https://annotate.codereading.club/#/file/LYe2FMDsBcHpQjWAjANiZsCsAmADAIwCcAZgQCbkCGALAOwDGAzOFkQBxVXhc1UPsi5LFSx0aANhoEJeGrADOAJwaxUAS0wMlPaOFgklYALRVIAT2gALdZADmAOgBWCoA"


randomPdf =
    "/random.pdf"


syntaxAnnotate =
    "https://annotate.codereading.club/#/file/OoUwRg0glgLg9KSs5gDYHsxwIwDMBMAJvgIYCc+I4AHAMzZgiGEAMDYYArGAGxkAsJFiHxlc5ErmrY4AZXQBXAE4BjEAnABhdEvW6AdoRBKo+gOZwAzjACeqdQEUF6GCEsAREjBIA6FQAd-IA"


syntaxPdf =
    "/syntax.pdf"


{-| The defined slides.
Use these to build your deck in Slides.elm
-}
type
    Section
    ----
    -- Club guidelines & group reflection
    ----
    = SessionStartFirstClub StartInfo
    | SessionStart StartInfo
    | WorkshopIntro StartInfo
    | WhyCodeReading
    | WhyDoingThis
    | WhatAreWeThinking
    | SecondThoughts
    | Break
    | Reflect
    | Feedback
    | SessionEnd EndInfo
      ----
      -- First Look at a piece of code
      ----
    | FirstGlance
    | Syntax
    | AnnotateStructure AnnotateInfo
    | ListNames
    | RandomLine
    | ImportantLines
    | Summarise
      ----
      -- Second Look at the same code
      ----
    | RecapStructure (List Int)
    | CentralThemes
    | CentralConcepts
    | DecisionsMade
    | DecisionsConsequences
    | DecisionsWhy
    | DecisionSummary


slideHeadingFromSection : Section -> List CustomContent
slideHeadingFromSection section =
    [ slideHeading
        (case section of
            SessionStartFirstClub _ ->
                "Code Reading Club"

            SessionStart _ ->
                "Code Reading Club"

            WorkshopIntro _ ->
                "Code Reading Club"

            WhyCodeReading ->
                "Code Reading Club roots"

            WhyDoingThis ->
                "Why are we doing this?"

            WhatAreWeThinking ->
                "What are we thinking?"

            SecondThoughts ->
                "Second thoughts?"

            Break ->
                "Take a break"

            Reflect ->
                "Reflect on the session"

            Feedback ->
                "Reflect on the session"

            SessionEnd _ ->
                "Q & A and next steps"

            FirstGlance ->
                "First glance"

            Syntax ->
                "Syntax knowledge"

            AnnotateStructure _ ->
                "Code structure"

            ListNames ->
                "Naming things"

            RandomLine ->
                "Random Line"

            ImportantLines ->
                "Content"

            Summarise ->
                "Summary"

            RecapStructure _ ->
                "Code structure"

            CentralThemes ->
                ""

            CentralConcepts ->
                ""

            DecisionsMade ->
                "The decisions made in the code"

            DecisionsConsequences ->
                "Consequences of the decisions"

            DecisionsWhy ->
                "The 'why' of the decisions"

            DecisionSummary ->
                "Decisions, consequences and why"
        )
    , styledSeparator
    ]


sectionIntroFromSection : Section -> List CustomContent
sectionIntroFromSection section =
    case section of
        SessionStartFirstClub _ ->
            []

        SessionStart _ ->
            []

        WorkshopIntro _ ->
            []

        WhyDoingThis ->
            []

        WhyCodeReading ->
            [ slideHeading2 "A history in 3 parts"
            , bullets
                [ bullet "1. Felienne's research"
                , bullet "2. Katja's problem"
                , bullet "3. Summary of what we discovered"
                ]
            ]

        WhatAreWeThinking ->
            [ slideP "This is a chance to get to know each other. It's important to be aware of who you are sharing this space with - so the club can be a success for everyone."
            , slideP "Take a few minutes to think about what's on your mind."
            , slideP "Is there something you want to share with the group about yourself?"
            , slideP "Is there something you are unsure or curious about right now?"
            ]

        SecondThoughts ->
            []

        Break ->
            []

        Reflect ->
            []

        Feedback ->
            []

        SessionEnd _ ->
            []

        FirstGlance ->
            [ slideP "The goal of this exercise is to practice to get a first impression of code and act upon that."
            , slideP "We all have different instincts and strategies for where to start when faced with a new piece of code."
                |> hide
            , bulletLink "Code in the annotation tool" glanceAndAnnotateAnnotate
                |> hide
            , bulletLink "Code pdf" glanceAndAnnotatePdf
                |> hide
            , slideP "It doesn't matter how trivial you think the first and second things you noticed are."
                |> hide
            , item (img [ src "example-first-glance.png", style "width" "120%", style "margin" "-10px 0 0 -10%" ] [])
                |> hide
            ]

        Syntax ->
            []

        AnnotateStructure _ ->
            [ slideP "The goal of this exercise is to be a concrete thing to *do* when looking at new code for the first time."
            , slideP "New code can be scary, doing something will help!"
            , item (img [ src "dannotated-code.png", style "height" "260px" ] [])
            , item (img [ src "annotated-code.png", style "height" "260px" ] [])
            , item (img [ src "scribbled-code.png", style "height" "260px", style "margin" "-20px 20px 0 0" ] [])
            ]

        ListNames ->
            [ slideHeading2 "If you ask 2 developers to name a thing, there is only a 7% chance they come up with the same name."
            , slideP "Dror Fietelson - \"How developers choose names\""
            , item (img [ src "/elm-anxious.jpg", style "height" "250px" ] [])
            , item (img [ src "/react-anxious.jpg", style "height" "250px" ] [])
            ]

        RandomLine ->
            []

        ImportantLines ->
            [ slideHeading2 "What does it mean to be important?"
            , slideP "Your brain prefers to see things it already knows, so if you don't make decisions, you might focus on the least important parts."
            , slideP "Important can mean whatever you want it to. If it's helpful, try to think of it as a line that you might highlight when reading a text."
            ]

        Summarise ->
            []

        RecapStructure _ ->
            []

        CentralThemes ->
            []

        CentralConcepts ->
            []

        DecisionsMade ->
            []

        DecisionsConsequences ->
            []

        DecisionsWhy ->
            []

        DecisionSummary ->
            [ slideHeading2 "There's more where that came from..."
            ]


sectionIntro : Section -> ( Bool, List SharedType.CustomContent )
sectionIntro section =
    ( False
    , slideHeadingFromSection section
        ++ sectionIntroFromSection section
    )


slideContent : Section -> List ( Bool, List SharedType.CustomContent )
slideContent section =
    case section of
        SessionStartFirstClub { facilitatedBy, groupWorkspaceLink, annotationLink, pdfLink } ->
            [ ( False
              , [ codeReadingWordmark
                , styledSeparator
                ]
                    ++ slideHeadingFromSection section
                    ++ [ slideP ("with " ++ facilitatedBy)
                       , slideP "hello@codereading.club | https://codereading.club"
                       , slideHr
                       , bullets
                            [ bulletLink "Code of conduct" "https://codereading.club/conduct"
                            , bulletLink "Group workspace" groupWorkspaceLink
                            , bulletLink "Code in annotation tool" annotationLink
                            , if String.length pdfLink > 0 then
                                bulletLink "Code pdf to download" pdfLink

                              else
                                item (text "")
                            ]
                       , slideHr
                       , bullets
                            [ bullet "Hello! What is code reading? Why are we all here? How does it work?"
                            , bullet "Don't look at the code until we start the first exercise."
                            , bullet "First make independent notes."
                            , bullet "Then copy any thoughts you want to our shared board."
                            ]
                       , item (h2 [ style "margin-top" "-20px" ] [ text "Any questions before we start?" ]) |> hide
                       ]
              )
            ]

        SessionStart { facilitatedBy, groupWorkspaceLink, annotationLink, pdfLink } ->
            [ ( False
              , [ codeReadingWordmark
                , styledSeparator
                , slideHeading3 ("with " ++ facilitatedBy)
                , slideP "hello@codereading.club | https://codereading.club"
                , slideHeading2 "The plan" |> hide
                , bullets
                    [ bullet "1. What is Code Reading Club?"
                    , bullet "2. How it will work"
                    , bullet "3. Try some exercises together"
                    , bullet "4. Questions & Answers"
                    ]
                    |> hide
                ]
              )
            , ( False
              , [ codeReadingWordmark
                , styledSeparator
                , slideHeading3 "What is Code Reading Club?"
                , bullets
                    [ bulletLink "Code of conduct" "https://codereading.club/conduct"
                    , bullet "codereading.club/conduct"
                    , bullet ""
                    , bulletLink "Group workspace" groupWorkspaceLink
                    , bullet ""
                    , bulletLink "Code in annotation tool" annotationLink
                    , if String.length pdfLink > 0 then
                        bulletLink "Example annotation" pdfLink

                      else
                        item (text "")
                    ]
                ]
              )
            , ( False
              , [ codeReadingWordmark
                , styledSeparator
                , slideHeading3 "How it will work"
                , bullets
                    [ bullet "Grab a copy of the code (paper or digital)"
                    , bullet "I'll keep the exercises & timer posted on my screenshare"
                    , bullet "Join the group workspace (make a personal board for notes if you want)"
                    , bullet "Make independent notes"
                    , bullet "After each exercise copy any thoughts you want to share the group board"
                    ]
                ]
              )
            ]

        WorkshopIntro { facilitatedBy, groupWorkspaceLink, annotationLink, pdfLink } ->
            [ ( False
              , [ codeReadingWordmark
                , styledSeparator
                , slideHeading3 ("a Space4 masterclass with " ++ facilitatedBy)
                , slideHeading2 "The plan" |> hide
                , bullets
                    [ bullet "1. What is Code Reading Club?"
                    , bullet "2. The foundations of Code Reading Club"
                    , bullet "3. Why are we here?"
                    , bullet "4. Exercise tasters (with break)"
                    , bullet "5. Questions & Answers"
                    ]
                    |> hide
                , slideHeading2 "Any questions before we start?" |> hide
                ]
              )
            , ( False
              , [ codeReadingWordmark
                , styledSeparator
                , slideHeading3 "What is Code Reading Club?"
                , bullets
                    [ bulletLink "Code of conduct" "https://codereading.club/conduct"
                    , bullet "https://codereading.club/conduct"
                    , bullet ""
                    , bulletLink "Code pdf tool" "https://pdf.codereading.club"
                    , bullet "https://pdf.codereading.club"
                    , bullet ""
                    , bulletLink "Code annotation tool" "https://annotate.codereading.club"
                    , bullet "https://annotate.codereading.club"
                    , bullet ""
                    , bullet "Discord community & github (@CodeReadingClubs) with resources"
                    , if String.length pdfLink > 0 then
                        bulletLink "Example annotation" pdfLink

                      else
                        item (text "")
                    ]
                ]
              )
            ]

        WhyCodeReading ->
            [ sectionIntro section
            , ( False
              , slideHeadingFromSection section
                    ++ [ slideHeading2 "Felienne's Research"
                       , bullets
                            [ bullet "Writing vs. Reading"
                            , bullet "Cognative processes when we read"
                            , bulletLink "Felienne Hermans' slides about reading" "/felienne-slides.pdf"
                            , bullet "Benefits of delibrate practice"
                            ]
                       ]
              )
            , ( False
              , slideHeadingFromSection section
                    ++ [ slideHeading2 "Katja's problem"
                       , bullets
                            [ bullet "Developers as rewriters"
                            , bullet "\"Looks good to me\" code reviews"
                            , bullet "Imposter vs. Expert"
                            , bullet "Diving into a new codebase or language"
                            ]
                       ]
              )
            , ( False
              , slideHeadingFromSection section
                    ++ [ slideHeading2 "What we discovered"
                       , bullets
                            [ bullet "Writing with humans in mind"
                            , bullet "Appreciation of other perspectives"
                            , bullet "A shared language"
                            , bullet "Problem solving & discovery together"
                            , bullet "A new set of skills to practice"
                            ]
                       ]
              )
            ]

        WhyDoingThis ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ slideP "Take a few minutes to talk about your motivation for doing the club. This is important because it will help you support each other and make it more likely that your group will feel that the club sessions have value for them."
                       , container (div [])
                            [ timedHeading "2" "Independently" "Note down one thing"
                            , bullets [ bullet "that you are looking forward to or excited about", bullet "that you are worried or confused about" ]
                            , item (img [ src "example-excited-worried.png", style "height" "250px" ] [])
                            ]
                            |> hide
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ container (div [])
                            [ timedHeading "5" "Together" "Discuss"
                            , bullets
                                [ bullet "Give everyone a chance to read out their hopes and fears"
                                , bullet "Discuss what you want to get out of the club"
                                , bullet "Think about how to accommodate members with varying levels of experience and confidence"
                                ]
                            ]
                       ]
              )
            ]

        WhatAreWeThinking ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ container (div [])
                            [ timedHeading "1" "Independently" "Note down one thing"
                            , slideP "something about why you are here"
                            , slideP "something you know about that you want to share"
                            , slideP "something you are confused about or want to ask about this group"
                            , slideP "- or -"
                            , slideP "something you are excited about"
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ container (div [])
                            [ timedHeading "5" "Everyone" "Share 1 thing"
                            , slideP ""
                            , slideHeading3 "Share our expectations for the session"
                            , item (img [ src "react-huffy.jpg", style "height" "250px" ] [])
                            , item (img [ src "elm-cautious.jpg", style "height" "250px" ] [])
                            , item (img [ src "elm-exhilerated.jpg", style "height" "250px" ] [])
                            , item (img [ src "react-confident.jpg", style "height" "250px" ] [])
                            , item (img [ src "react-lucky.jpg", style "height" "250px" ] [])
                            ]
                       ]
              )
            ]

        SecondThoughts ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ slideP "What's the most disorientating thing so far? This can be something about the Code Reading Club process or the code sample we are looking at."
                       , slideP "Is something confusing or worrying you? Are you feeling excited or uneasy?"
                       , container (div [])
                            [ timedHeading "2" "Independently" "Note down 1 or 2 things"
                            , item (img [ src "example-excited-worried.png", style "height" "250px" ] [])
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ container (div [])
                            [ timedHeading "5" "Together" "Discuss"
                            , bullets
                                [ bullet "Give everyone a chance share if they want to"
                                , bullet "Discuss what you want to get out of the club"
                                , bullet "Think about how to accommodate members with varying levels of experience and confidence"
                                ]
                            ]
                       ]
              )
            ]

        Break ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Together & Independently" ""
                       , slideHeading2 "If you need something to do..."
                       , slideHeading3 "tell your neighbour something great about a programming language you like."
                       , item (img [ src "cards1.jpg", style "height" "250px" ] [])
                       , item (img [ src "cards2.jpg", style "height" "250px" ] [])
                       , item (img [ src "cards4.jpg", style "height" "250px" ] [])
                       ]
              )
            ]

        Reflect ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ slideP "If you have time, it's helpful to wrap up the session with a little reflection."
                       , timedHeading "5" "Together" "Note down things"
                       , bullets
                            [ bullet "that went well or felt good"
                            , bullet "you want to try to do differently next time because they didn't work or felt bad"
                            ]
                       ]
              )
            ]

        Feedback ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ slideP "If you have time, it's helpful to wrap up the session with a little reflection."
                       , timedHeading "5" "Together" "Note down things"
                       , bullets
                            [ bullet "Feedback we can act on - both good and bad is helpful"
                            , bullet "Observations about the experience - in the club today or thoughts you've had between clubs"
                            ]
                       ]
              )
            ]

        SessionEnd { codeDescription, codeLink } ->
            [ ( False
              , slideHeadingFromSection section
                    ++ [ slideHeading2 "Any questions?"
                       , slideP "Get in touch - email: hello@codereading.club | twitter: @codereadingclub"
                       , slideHeading2 "Continue with Code Reading!"
                       , bullets
                            [ bullet "Code reading club resources: https://codereading.club"
                            , bullet "Read Felienne's book! The Programmer's Brain"
                            , bullet "Start a club"
                            , bullet "Join a club"
                            , bullet "Join our discord"
                            , bullet "Apply practices to onboarding or as interview tool"
                            ]
                       ]
              )
            ]

        -- First Look
        FirstGlance ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "1" "Independently" "Glance at the code"
                       , slideP "It's important that what you use is your  immediate reaction, don't overthink it!"
                       , bullets
                            [ bullet "1. Look at code for a few seconds. Note the first thing that catches your eye."
                            , bullet "2. Look again for a few more seconds. Note the second thing that catches your eye."
                            , bullet "3. Now think about why you noticed those things first & note that down."
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "2" "3 People" "Share your first, second & why"
                       , slideP "It might be tempting for some people to start talking about the big picture, but for this exercise we focus on the details we notice, rather than attempt to summarise."
                       , slideHeading3 "Talk about why things might have jumped out for different people."
                       , bullets
                            [ bullet "How do those initial observations help with deciding what to look at next?"
                            , bullet "What lines, facts or concepts were noticed by many vs. few people in the group?"
                            ]
                       , slideHeading3 "Reflect also on what kind of knowledge you used in this exercise."
                       , bullets
                            [ bullet "Knowledge of the domain, of the programming language? Of a framework?"
                            , bullet "What knowledge do you think might be needed to better understand this code?"
                            ]
                       ]
              )
            ]

        Syntax ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ slideP "The goal of this exercise is to practice to make sure everyone in club is familiar with syntactic elements of the code."
                       , timedHeading "4" "Independently" "Examine syntax"
                       , bullets
                            [ bulletLink "Code in the annotation tool" syntaxAnnotate
                            , bulletLink "Code pdf" syntaxPdf
                            ]
                       , slideP "Look at the code and examine syntactic elements. Do you know the meaning of all elements? You can use these questions as a guide:"
                       , bullets
                            [ bullet "Is it clear to you what the role of each block in the code is (function, condition, repetition etc)?"
                            , bullet "Do you recognize all operators?"
                            , bullet "Take the remainder of the time to think about what other things are unfamiliar."
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "4" "5 people" "Say one line & syntax question"
                       , slideP "Talk about unfamiliar constructs."
                       , slideP "Were there constructs that were unfamiliar?"
                       , bullets
                            [ bullet "If so, are there members of the group who know the meaning?"
                            , bullet "If not, can you look up the constructs?"
                            ]
                       , slideP "Why are the syntactic constructs unfamiliar?"
                       , slideP "Are they idiosyncratic to this language or code base?"
                       ]
              )
            ]

        AnnotateStructure { annotationLink, pdfLink } ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Independently" "Examine structure"
                       , slideP "Highlight the places where things are defined a draw links to where they are used. Use different colours. There is no \"right\" way to do this excercise. Use your insticts to explore how the pieces of code flow."
                       , bullets
                            [ bulletLink "Code to annotate" glanceAndAnnotateAnnotate
                            , if String.length pdfLink > 0 then
                                bulletLink "Code pdf to download" glanceAndAnnotatePdf

                              else
                                item (text "")
                            ]
                       , slideHeading3 "Start by identifying"
                       , bullets
                            [ bullet "Variables"
                            , bullet "Functions / Methods"
                            , bullet "Classes / Instantiation"
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "2" "One person" "Present"
                       , slideHeading3 "Share your annotations"
                       , slideHeading3 "Talk through your process and what you discovered"
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "One at a time" "Add one new thing"
                       , bullets
                            [ bullet "Did you have trouble deciding what constituted a variable, function or class?"
                            , bullet "What patterns are visible from the colors and links only?"
                            , bullet "How does the data flow through the code?"
                            , bullet "What parts of the code seem to warrant more attention?"
                            , bullet "How did you choose which colours to use?"
                            , bullet "What strategies did you use to identify different elements in the code?"
                            ]
                       ]
              )
            ]

        ListNames ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "In Pairs" "Identify things that are named"
                       , bullets
                            [ bulletLink "Code in the annotation tool" namesAnnotate
                            , bulletLink "Code pdf" namesPdf
                            ]
                       , slideP "Use the annotation tool to highlight names. This is one method for discovering how the code fits together and its intentions."
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Together" "What can we learn from these names?"
                       , slideHeading3 "Identify patterns"
                       , bullets
                            [ bullet "Are there names that are ambiguous when looked at without context?"
                            , bullet "Are there any conventions followed or not followed with the naming?"
                            ]
                       , slideHeading3 "Talk about meaning"
                       , bullets
                            [ bullet "Which come from the domain?"
                            , bullet "Which come from constructs / concepts in programming?"
                            , bullet "Which elements are related to each other, from the names only?"
                            ]
                       ]
              )
            ]

        RandomLine ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "3" "Independently" "Examine the line"
                       , bullets
                            [ bulletLink "Code in the annotation tool" randomAnnotate
                            , bulletLink "Code pdf" randomPdf
                            ]
                       , slideP "Select a random line. It can be helpful to randomly pick 3 line numbers and have the facilitator choose from them, which they think will be most interesting to talk about; but surprisingly, even a blank line can generate some conversation!"
                       , slideP "Debugging often starts with a line number."
                       , slideP "Start by looking at the line itself, then think about how it relates to the code around it."
                       , bullets
                            [ bullet "What is the main idea of this line?"
                            , bullet "What lines does it relate to and why?"
                            , bullet "What strategies & prior knowledge are you using to figure this out?"
                            ]
                       ]
              )
            , ( True
              , [ slideHeading "The Line in Context"
                , timedHeading "5" "Everyone" "Discuss"
                , bullets
                    [ bullet "What is the 'scope' of the random line?"
                    , bullet "What part of the code was seen as related?"
                    , bullet "How does the line fit into the rest of the code base?"
                    ]
                , slideP "Take turns in the group, and let every member talk about the code for 30 seconds (could also be one sentence each). Try to add new information and not repeat things that have been said, and repeat until people do not know new things anymore or we run out of time."
                ]
              )
            ]

        ImportantLines ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "4" "Independently" "Identify important lines"
                       , bullets
                            [ bullet "Identify the 4 lines you consider most important"
                            , bullet "List your 4 line numbers together"
                            , bullet "Think about why you chose them"
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "2" "Everyone together" "List line numbers chosen"
                       , slideHeading3 "Get a sense of"
                       , bullets
                            [ bullet "lines covered by many people?"
                            , bullet "lines named but not by a lot of people"
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "One at a time" "Add one new thing"
                       , bullets
                            [ bullet "Did you choose a line because it worried you?"
                            , bullet "Did you choose a line you understood, or one that confused you?"
                            , bullet "Did you choose a line with a comment?"
                            , bullet "Did you choose a return statement or a function declaration?"
                            ]
                       ]
              )
            ]

        Summarise ->
            [ sectionIntro section
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Independently" "Summarise"
                       , slideP "The goal of this exercise is to think about the core purpose or function of this code."
                       , bullets
                            [ bullet "try to write down the essence of the code in a few sentences"
                            ]
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "8" "Together" "Discuss"
                       , bullets
                            [ bullet "topics covered by many vs few"
                            , bullet "strategies used to create the summary (e.g. method names, documentation, variable names, prior knowledge of system)"
                            ]
                       ]
              )
            ]

        -- Second Look
        RecapStructure importantLines ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Independently" "Remember"
                       , slideP "Look at the pieces that make up the code and how they connect or flow together. This exercise is meant as a recap of the first session on the code, and as a way to onboard people that might have missed the first session on this code snippet."
                       , slideP "Looking at an annotated copy from the last session, make some notes about what parts of the code stand out and why. If you did not participate in the previous session, highlight the variables, methods and classes. Start to draw links between where they are instantiated and used."
                       , bullets
                            [ bullet "Study the patterns and think about what they tell you."
                            ]
                       , slideP "When we looked at this code last month, we talked about important lines together."
                       , slideP ("These were chosen by a few people: " ++ String.join ", " (List.map String.fromInt importantLines))
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Together" "Review & Summarise"
                       , slideP "Someone who was in the previous session could summarise or where we got to or we could think about:"
                       , bullets
                            [ bullet "What direction does the code flow in?"
                            , bullet "What parts stand out for lack, or excess, of links to other parts?"
                            , bullet "What parts of the code seem to warrant more attention?"
                            , bullet "Did anyone have trouble deciding what constituted a variable, function or class?"
                            , bullet "What thoughts did you have when thinking about the structure?"
                            ]
                       ]
              )
            ]

        CentralThemes ->
            [ ( True, [] ) ]

        CentralConcepts ->
            [ ( True, [] ) ]

        DecisionsMade ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "2" "Independently" "Consider code choices"
                       , slideP "Reexamine the code snippet and list decisions of the creator(s) of the code, for example a decision to use a certain design pattern or use a certain library or API."
                       , bullets
                            [ bullet "Try not to judge the decisions as good or bad"
                            , bullet "Focus on what decisions the developer(s) had to make, not why they made them"
                            ]
                       , item (img [ src "example-code-decisions.png", style "height" "250px" ] [])
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "10" "Together" "Discuss"
                       , bullets
                            [ bullet "Decisions covered by many vs few"
                            , bullet "Strategies used to decide (e.g. method names, documentation, variable names, prior knowledge of system)"
                            ]
                       ]
              )
            ]

        DecisionsConsequences ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "5" "Independently" "Consider the consequences"
                       , slideP "Think about the consequences of the decisions that were made. These could be the decisions you found yourself in the previous exercise or a decision someone else pointed out."
                       , slideP "You might want to think consider the impact of the decisions this code on:"
                       , bullets
                            [ bullet "readability"
                            , bullet "performance"
                            , bullet "extendability"
                            ]
                       , item (img [ src "example-consequences.png", style "height" "210px" ] [])
                       ]
              )
            , ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "10" "Together" "Discuss"
                       , bullets
                            [ bullet "Consequences covered by many vs few"
                            , bullet "Different types of consequence chosen (e.g. readability, extendability, performance)"
                            , bullet "Pros of these decisions"
                            , bullet "Possible cons of these decisions"
                            ]
                       ]
              )
            ]

        DecisionsWhy ->
            [ ( True
              , slideHeadingFromSection section
                    ++ [ timedHeading "10" "Together" "Make statements"
                       , slideP "Can you understand why the code was designed this way?"
                       , bullets
                            [ bullet "What assumptions do these decisions rely on?"
                            , bullet "Can you think of reasons these decisions might have been made?"
                            , bullet "What alternatives would have been possible?"
                            ]
                       ]
              )
            ]

        DecisionSummary ->
            [ ( False
              , [ decisionsConsequencesWhy
                , styledSeparator
                ]
                    ++ [ slideHeading2 "Looking at a piece of code again"
                       , slideHeading3 "Consider code choices"
                       , slideP "Try not to judge the decisions as good or bad"
                       , slideHeading3 "Consider the consequences"
                       , slideP "Consider the impact of the decisions on e.g. readability, performance, extendability"
                       , slideHeading3 "Consider potential reasons"
                       , slideP "Can you understand why the code might have been designed this way?"
                       ]
              )
            ]



-- Markup helpers


codeReadingWordmark : CustomContent
codeReadingWordmark =
    item (h1 [] [ text "Code", br [] [], span [ class "syntax-highlight" ] [ text "Reading" ], br [] [], text "Club" ])


decisionsConsequencesWhy : CustomContent
decisionsConsequencesWhy =
    item (h1 [] [ text "Decisions", br [] [], span [ class "syntax-highlight" ] [ text "Consequences" ], br [] [], text "Why" ])


slideHeading : String -> CustomContent
slideHeading title =
    item (h1 [] [ text title ])


slideHeading2 : String -> CustomContent
slideHeading2 heading =
    item (h2 [] [ text heading ])


slideHeading3 : String -> CustomContent
slideHeading3 heading =
    item (h3 [] [ text heading ])


slideHr : CustomContent
slideHr =
    item (hr [] [])


styledSeparator : CustomContent
styledSeparator =
    item (hr [ class "separator" ] [])


slideP : String -> CustomContent
slideP paragraph =
    item (p [ class "paragraph" ] [ text paragraph ])


slidePMarkdown : String -> CustomContent
slidePMarkdown paragraph =
    item (Markdown.toHtml [] paragraph)


timedHeading : String -> String -> String -> CustomContent
timedHeading minutes who heading =
    let
        label =
            if minutes == "1" then
                " minute"

            else
                " minutes"
    in
    container (h2 [])
        [ item (text heading)
        , item (span [ class "time" ] [ text (minutes ++ label) ])
        , item (span [ class "who" ] [ text who ])
        ]


bullets : List CustomContent -> CustomContent
bullets =
    container (ul [])


bullet : String -> CustomContent
bullet str =
    item (li [] [ text str ])


bulletLink : String -> String -> CustomContent
bulletLink str url =
    item (li [] [ a [ href url ] [ text str ] ])


{-| Custom slide that sets the padding and appends the custom content
-}
paddedSlide : ( Bool, List CustomContent ) -> CustomSlide
paddedSlide ( showStopwatch, content ) =
    slide
        [ container
            (div [ class "slides" ])
            (content
                ++ [ if showStopwatch then
                        custom
                            { displayTime = 0
                            , startTime = 0
                            , timerStarted = False
                            }

                     else
                        item (img [ src "icon.png", class "stopwatch" ] [])
                   , item
                        (div [ class "footer" ]
                            [ text "Slides for this workshop: https://intro-to-code-reading-club.netlify.app"
                            ]
                        )
                   ]
            )
        ]

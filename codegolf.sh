#!/bin/bash

courses=("fib")
languages=("python")

function usage {
    echo "$0 play <course> <file> <language>"
    echo "Courses:"
    echo "    fib"
    echo "languages:"
    echo "    python"
    echo "notes:"
    echo "    if a compiled languge is used, it is expected that the file is"
    echo "    precompiled before calling this program.  Then the file param"
    echo "is ran, gither by the virtual machine or system"
}

function run_file {
    case $2 in
    #there has to be some way to implement this with arrays to make it 
    #dynamic.. I'll have to look it up later
    python)
        echo "$(python3 $2)"
        ;;
    *)
        ;;
    esac
}

#1: course, #2: file, #3 language
function play {
    if ! [[ "$(< ./$1.ans | xargs)" = "$(run_file $3 $2 | xargs)" ]];
    then
        echo "incorrect! Didn't get the right answer"
        exit
    fi

    echo "Character count: $(echo $2 | wc -c)"

}

function check_course {
    for course in $courses
    do
        if [[ "$1" =~ "$course" ]];
        then
            echo 1
        fi
    done
    echo 0
}

function check_language {
    for language in $languages
    do
        if [[ "$1" =~ "$language" ]];
        then
            echo 1
        fi
    done
    echo 0
}


function argcheck {

    case $1 in
        play)
            if [ "$(check_course "$2")" = "0" ];
            then
                echo "Not a valid course!"
                exit 1
            fi

            if [ "$(check_language "$4")" = "0" ];
            then
                echo "Not a valid language!"
                echo "For accepted languages run: $0 lang"
                exit 1
            fi

            if [ -z ${3+x} ]; then
                echo "Need to supply file !"
                exit 1
            fi
            play $2 $3 $4
            ;;
        *)
            echo "What?"
            ;;
    esac
}

case $1 in
play)
    argcheck $1 $2 $3 $4
    ;;
*)
    echo "What?"
    usage
    ;;
esac

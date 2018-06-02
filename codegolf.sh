#!/bin/bash

function main {
    echo main
}

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

#$1 languge, $2: file
function runfile {
    case $1 in
    python)
        python3 $2
        ;;
    *)
        echo "Unsupported language! Shouldn't get here!!!!")
        ;;
    esac
}
#1: course, #2: file, #3 language
function play {
    if [[ $(< ~/codegolf/$1.ans) != $(runfile $3 $2) ]]; then
        echo "Incorrect!!!"
    else
        echo "Correct!"
    fi
}

function argcheck {
    case $1 in
        play)
            if ! [[ "$2" =~ ^(fib)$ ]]; then
                echo "Not a valid course!"
            fi
            if ! [[ "$4" =~ ^(python)$ ]]; then
                echo "Not a valid language!"
            fi
            if [ -z ${3+x} ]; then
                echo "Need to supply file !"
                exit 1
            fi
            ;;
        *)
            echo "What?"
            ;;
    esac
}

case $1 in
play)
    echo "Playing!"
    argcheck $1 $2 $3 $4
    ;;
*)
    echo "What?"
    usage
    ;;
esac

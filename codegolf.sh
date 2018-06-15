#!/bin/bash

courses=("fib")
languages=("python")

function usage {
    echo "$0 play <file>"
    echo "Courses:"
    echo "    fib"
    echo "languages:"
    echo "    python"
    echo "notes:"
    echo "  For compiled languages like c, cpp, rust, java, etc.. just include"
    echo "  the source file, this script will take care of running it."
    echo
    echo "  You have to name your source file properly or the script won't be"
    echo "  able to interpret which course to run"
    echo
    echo "  Format:     <coursename>.<file extention>"
    echo "  Example:    fib.py"
}

function list_courses {
    #should implement this dynamically
    #could have a directory of all of the answer files and then just strip
    #those
    for file in ./answers/*
    do
        echo $(basename $file)
    done
}

function print_course_help {
    cat ./descriptions/$1
}

function run_file {
    case $1 in
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
    if ! [[ "$(cat "answers/$1" | xargs)" = "$(run_file $3 $2 | xargs)" ]];
    then
        echo "incorrect! Didn't get the right answer"
        exit
    else
        echo "Character count: $(wc -m $2)"
    fi

}

function get_lang {
    case $(echo $1 | cut -d. -f2) in
    py)
        echo "python"
        ;;
    *)
        ;;
    esac
}

function get_course {
    pot=$(echo $1 | cut -d. -f1)

    for course in answers/*
    do
        if [ "$pot" = "$(basename $course)" ];
        then
            echo "$pot"
        fi
    done
}


case $1 in
play)

    lang="$(get_lang $2)"
    course="$(get_course $2)"

    #make checks independent and more verbose
    if [ -z ${2+z} ];
    then
        echo "Need to provide file!"
        exit 1

    elif [ -z ${course+z} ];
    then
        echo "Could not find course for $course"
        exit 1

    elif [ -z ${lang+z} ];
    then
        echo "Could not find language for $lang"
        exit 1
    fi

    play "$course" "$2" "$lang"
    ;;
courses)
    if [ ! -z ${2+z} ];
    then
        print_course_help $2
        exit
    fi
    list_courses
    ;;
*)
    echo "What?"
    usage
    ;;
esac

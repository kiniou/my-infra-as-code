#!/bin/sh
set -e

FORMULAS_DIR=../formulas

check_symlink () {
    # echo "PWD: $(pwd)"
    if [ ! -h "$1" ]
    then
        echo "❌ ${formula_states} link is missing"
        return 1
    fi

    if ! (readlink -e "${1}")
    then
        echo "❌ ${formula_states} link is weird"
        return 1
    fi

    linked_to=$(readlink -q -e "${1}")
    realpath_to=$(realpath "${2}")

    if [ ! "$linked_to" = "$realpath_to" ]
    then
        echo "❌ ${1} link does not point to ${2}"
        return 1
    fi
    echo "✅ ${formula_states} link is present and points to ${2}"
}

cd $(dirname $0)
(
    cd ../states
    for formula_dir in $(find ${FORMULAS_DIR} -maxdepth 1 -mindepth 1 -type d)
    do
        formula=$(basename ${formula_dir})
        echo "Installing ${formula}"
        formula_states=$(echo ${formula} | sed -e 's/-formula$//')
        formula_path=${FORMULAS_DIR}/${formula}/${formula_states}
        if ! check_symlink "${formula_states}" "${formula_path}"
        then
            echo "🔗 (re)Installing symlink "
            ln -sf "${formula_path}" "${formula_states}"
            check_symlink "${formula_states}" "${formula_path}"
        fi
    done
)

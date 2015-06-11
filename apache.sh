#!/bin/bash
DIR="${BASH_SOURCE%/*}"
. $DIR/config.sh

#######################################
#             Apache Utils            #
#######################################

function a2ensite {
    if [ -e $SITES_AVAILABLE_FOLDER/$1 ]
    then
        file=$1
    elif [ -e $SITES_AVAILABLE_FOLDER/$1\.conf ]
    then
        file=$1\.conf
    elif [ $# -ne 1 ]
    then
        echo 'Illegal number of parameters'
        return
    elif [$# -eq 0]
    then
        echo 'No arguments provided'
        return
    else
        echo 'File does not exist.'
        return
    fi

    if [ -e $SITES_ENABLED_FOLDER/$file ]
    then
        echo "$file already exists. Please disable before continuing."
        return
    fi

    sudo ln -s $SITES_AVAILABLE_FOLDER/$file /etc/apache2/sites-enabled
    echo 'Site successfully enabled. Restart Apache for changes to take effect'.
}

function a2dissite {
    if [ -e $SITES_ENABLED_FOLDER/$1 ]
    then
        file=$1
    elif [ -e $SITES_ENABLED_FOLDER/$1\.conf ]
    then
        file=$1\.conf
    elif [ $# -ne 1 ]
    then
        echo 'Illegal number of parameters'
        return
    elif [$# -eq 0]
    then
        echo 'No arguments provided'
        return
    else
        echo 'File does not exist.'
        return
    fi

    sudo rm $SITES_ENABLED_FOLDER/$file
    echo "Success fully disabled site $file."
}

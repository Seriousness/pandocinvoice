#!/bin/sh

function invoice {
    echo $FILE
    # convert to tex, go the way round .tex -> luatex because journal generation does not work when using pandoc conversion
    pandoc $FILE --wrap=none -f markdown -o $TEXNAME --template=./rechnung.tex
    # execute twice for all lines to be created
    lualatex $TEXNAME
    lualatex $TEXNAME

    # TODO!

    if [[ $EXPORT = 1 ]]
    then

        # pdfA-Standard for digital invoices
        gs -dPDFACompatibilityPolicy=3 -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -sProcessColorModel=DeviceCMYK  -dNOPAUSE -dQUIET -dBATCH -dPDFA -sOutputFile=$PDFANAME $PDFNAME
        # create Quarteryear-Dir if not there
        [ ! -d "$QUARTAL" ] && mkdir "$QUARTAL"
        # move created journal to datafolder
        mv ${FILE%.md}.journal "$QUARTAL"
        echo $PDFANAME
    fi

}

function dialog {
    read -p "$FILE yN" -n 1 -r
    
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo 1 

    else
        echo 0
    fi
}


for i in "$@"
do
case $i in
    -x|--export)
    EXPORT=1
    shift # past argument=value
    ;;
    -f=*|--file=*)
    FILE="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done






PDFNAME="${FILE%.md}.pdf"
TEXNAME="${FILE%.md}.tex"

#TODO ABSOLUT PATH
QUARTAL="../../../documents/outgoing/$(date +%Y)Q$(( ($(date +%-m)-1)/3+1 ))"
PDFANAME="$QUARTAL/${FILE%.md}_export.pdf"



#if file already exists ask if override
if [ -f $PDFANAME ]    
then
    
    echo "Invoice already exists!"

    if [[ $EXPORT == 1 ]]
    then
        
        if  [[ $(dialog "Invoice already exists, overwrite $(basename "$PDFANAME")?") == 1 ]]
        then
            invoice $FILE 
        else 
            echo "Abort ..."
        fi

    fi
    
# does not exist yet
else
    invoice $FILE
fi


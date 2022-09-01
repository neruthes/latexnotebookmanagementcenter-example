#!/bin/bash


SRCDIR="$1"
if [[ -z $SRCDIR ]]; then
    echo "[ERROR] You must supply SRCDIR path."
fi
if [[ ! -d $SRCDIR ]]; then
    echo "[ERROR] Cannot find SRCDIR '$SRCDIR'."
    exit 1
fi
BOOKNAME="$(basename $SRCDIR)"






TEXDEST="$(sed 's|^db|workdir/book|' <<< "$SRCDIR" )"
mkdir -p $TEXDEST
TEXDEST=$(dirname $TEXDEST/1)
mkdir -p "$TEXDEST" 2>/dev/null
rm -r "$TEXDEST" 2>/dev/null





LISTFILE="$(sed 's|book|.bookitems|' <<< "$TEXDEST")"
mkdir -p "$LISTFILE" 2>/dev/null
rm -r "$LISTFILE" 2>/dev/null
echo "" > $LISTFILE





for FN in $(find $SRCDIR -name '*.tex' | sort); do
    echo '\input{'$(realpath $FN)'}' >> $LISTFILE
    printf '\n\n' >> $LISTFILE
done

cat $LISTFILE

cat .tmpl/note-export-book.tex | sed 's|09be2d6729c44c5598b706c077f64b5f|\\input{'$LISTFILE'}|' | sed "s|BOOKNAME|$BOOKNAME|" > $TEXDEST.tex

ntex $TEXDEST.tex --2 --nosync

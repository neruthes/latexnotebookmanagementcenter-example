#!/bin/bash


SRC="$1"
if [[ -z $SRC ]]; then
    echo "[ERROR] You must supply src file path."
fi
if [[ ! -e $SRC ]]; then
    echo "[ERROR] Cannot find src '$SRC'."
    exit 1
fi

TEXDEST="$(sed 's|^db|workdir/single|' <<< "$SRC")"
rm -r "$TEXDEST" 2>/dev/null
mkdir -p "$TEXDEST" 2>/dev/null
rm -r "$TEXDEST" 2>/dev/null

cat .tmpl/note-export-single.tex | sed 's|09be2d6729c44c5598b706c077f64b5f|\\input{'$SRC'}|' > $TEXDEST

ntex $TEXDEST --nosync

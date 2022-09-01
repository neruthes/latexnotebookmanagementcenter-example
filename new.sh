#!/bin/bash

vCategory="$1"
vNickname="$2"
if [[ -z "$vCategory" ]]; then vCategory=Main; fi
if [[ -z "$vNickname" ]]; then vNickname=untitled; fi
mkdir -p db/$vCategory

DATECODE="$(TZ=UTC date +%Y.%m.%d)"
Count="$(find db -name "${DATECODE}*" | wc -l)"

NotePath="db/$vCategory/$DATECODE-$Count-$vNickname.tex"
touch "$NotePath"
cat .tmpl/note.tex | sed "s|vCategory|$vCategory|g" | sed "s|REALDATE|$(date '+%Y-%m-%d %H:%M')|g" > $NotePath

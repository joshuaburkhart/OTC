#!/bin/bash

PPTX_DIR=$1
LO_CLOSED=`ps -a | sed -n /LibreOffice/p`

if ! [ "${LO_CLOSED:-null}" = null ]; then
    echo Converting $PPTX_DIR/\*.pptx to pdf documents...
    /Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf --outdir ${PPTX_DIR}/ ${PPTX_DIR}/*.pptx
    echo Merging pdf documents...
    "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o ${PPTX_DIR}/merged_pptx.pdf ${PPTX_DIR}/*.pdf
    echo Done. Original pptx files combined into $PPTX_DIR/merged_pptx.pdf
else
    echo ERROR: LibreOffice already running. Assure LibreOffice is closed.
fi

#!/bin/sh
mogen=`which mogenerator`
PlistBuddy=/usr/libexec/PlistBuddy
HUMAN_FILES_OUTPUT_FOLDER=$PROJECT_DIR/Application/Models/entities
MACHINE_FILES_OUTPUT_FOLDER=$PROJECT_DIR/Application/Models/generated
MODEL_DATA_FOLDER=$PROJECT_DIR/Application/Models/Recipes.xcdatamodeld

#figure out current model version
CURRENT_MODEL_VERSION=`"$PlistBuddy" -c 'Print _XCCurrentVersionName' "$MODEL_DATA_FOLDER/.xccurrentversion"`


if [[ -x $mogen ]]; then
echo "Updating data objects from $MODEL_DATA_FOLDER/$CURRENT_MODEL_VERSION using $mogen"
"$mogen" -m "$MODEL_DATA_FOLDER/$CURRENT_MODEL_VERSION" -M "$MACHINE_FILES_OUTPUT_FOLDER" -H "$HUMAN_FILES_OUTPUT_FOLDER" --template-var arc=true
fi

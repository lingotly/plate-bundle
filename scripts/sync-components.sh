#!/bin/bash

# Init
rm -rf .tmp
mkdir .tmp

# Clone latest changes
curl -Lo .tmp/main.zip https://github.com/udecode/plate/archive/refs/heads/main.zip
mkdir .tmp/main
unzip .tmp/main.zip -d .tmp/main

# Copy all available components
rm -rf src/components
mkdir src/components
mkdir src/components/plate-ui
cp -r .tmp/main/plate-main/templates/plate-playground-template/src/components/plate-ui/* src/components/plate-ui

mkdir src/components/editor
cp -r .tmp/main/plate-main/templates/plate-playground-template/src/components/editor/* src/components/editor

rm -rf src/hooks
mkdir src/hooks
cp -r .tmp/main/plate-main/templates/plate-playground-template/src/hooks/* src/hooks

# Cleanup unwanted content
rm src/components/plate-ui/ai-menu.tsx
rm src/components/plate-ui/slash-input-element.tsx
rm src/components/plate-ui/code-*.tsx
rm src/components/plate-ui/calendar.tsx
rm src/components/plate-ui/date-element.tsx

rm src/components/editor/use-chat.tsx
rm src/components/editor/plate-editor.tsx
rm src/components/editor/use-create-editor.tsx

rm src/components/editor/plugins/ai-plugins.tsx
rm src/components/editor/plugins/copilot-plugins.ts
rm src/components/editor/plugins/editor-plugins.tsx

# Fix sources
sed -i 's/useEffect(() => {/useEffect(() => {\n    \/\/ @ts-ignore/' src/hooks/use-debounce.ts

# Add changes to git
git add src/.

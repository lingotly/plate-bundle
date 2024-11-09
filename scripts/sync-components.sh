#!/bin/bash

# Init
rm -rf .tmp
mkdir .tmp

# Clone latest changes
curl -Lo .tmp/main.zip https://github.com/udecode/plate/archive/refs/heads/main.zip
mkdir .tmp/main
unzip .tmp/main.zip -d .tmp/main

# Init structure
rm -rf src
mkdir src
mkdir src/registry
mkdir src/registry/default

# Copy all available components
mkdir src/registry/default/plate-ui
cp -r .tmp/main/plate-main/apps/www/src/registry/default/plate-ui/* src/registry/default/plate-ui

mkdir src/registry/default/components
mkdir src/registry/default/components/editor
cp -r .tmp/main/plate-main/apps/www/src/registry/default/components/editor/* src/registry/default/components/editor

mkdir src/registry/default/hooks
cp -r .tmp/main/plate-main/apps/www/src/registry/default/hooks/* src/registry/default/hooks

# Cleanup unwanted content
rm src/registry/default/plate-ui/ai-menu.tsx
rm src/registry/default/plate-ui/slash-input-element.tsx
rm src/registry/default/plate-ui/code-*.tsx
rm src/registry/default/plate-ui/calendar.tsx
rm src/registry/default/plate-ui/date-element.tsx

rm src/registry/default/components/editor/use-chat.tsx

rm src/registry/default/components/editor/plugins/ai-plugins.tsx
rm src/registry/default/components/editor/plugins/copilot-plugins.ts
rm src/registry/default/components/editor/plugins/editor-plugins.tsx

# Fix sources
sed -i 's/useEffect(() => {/useEffect(() => {\n    \/\/ @ts-ignore/' src/registry/default/hooks/use-debounce.ts

# Add changes to git
git add src/.

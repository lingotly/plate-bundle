#!/bin/bash

# Init
rm -rf .tmp
mkdir .tmp

# Clone latest changes
curl -Lo .tmp/main.zip https://github.com/udecode/plate/archive/refs/heads/main.zip
mkdir .tmp/main
unzip .tmp/main.zip -d .tmp/main

# Init structure
rm -rf registry
mkdir registry
mkdir registry/default

# Copy all available components
mkdir registry/default/plate-ui
cp -r .tmp/main/plate-main/apps/www/src/registry/default/plate-ui/* registry/default/plate-ui

mkdir registry/default/components
mkdir registry/default/components/editor
cp .tmp/main/plate-main/apps/www/src/registry/default/components/editor/* registry/default/components/editor

mkdir registry/default/hooks
cp -r .tmp/main/plate-main/apps/www/src/registry/default/hooks/* registry/default/hooks

# Cleanup unwanted content
rm registry/default/plate-ui/ai-menu.tsx
rm registry/default/plate-ui/slash-input-element.tsx
rm registry/default/plate-ui/code-*.tsx
rm registry/default/plate-ui/calendar.tsx
rm registry/default/plate-ui/date-element.tsx

rm registry/default/components/editor/use-chat.tsx

#rm registry/default/components/editor/plugins/ai-plugins.tsx
#rm registry/default/components/editor/plugins/copilot-plugins.ts
#rm registry/default/components/editor/plugins/editor-plugins.tsx

# Fix sources
sed -i 's/@\/registry\/default\/hooks\//..\/hooks\//' registry/default/plate-ui/*
sed -i 's/@\/registry\/default\/components\//..\/components\//' registry/default/plate-ui/*
sed -i 's/export const CaptionTextarea = withCn/export const CaptionTextarea: typeof CaptionTextareaPrimitive = withCn/' registry/default/plate-ui/caption.tsx
sed -i 's/useEffect(() => {/useEffect(() => {\n    \/\/ @ts-ignore/' registry/default/hooks/use-debounce.ts

# Add changes to git
git add registry/.

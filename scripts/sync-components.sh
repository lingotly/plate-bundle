#!/bin/bash

# Init
rm -rf .tmp
mkdir .tmp

# Clone latest changes
curl -Lo .tmp/main.zip https://github.com/udecode/plate/archive/refs/heads/main.zip
mkdir .tmp/main
unzip .tmp/main.zip -d .tmp/main

# Init structure
rm -rf registry/default
mkdir registry/default

# Copy all available components
mkdir registry/default/plate-ui
cp -r .tmp/main/plate-main/apps/www/src/registry/default/plate-ui/* registry/default/plate-ui

# Copy all available libs
#mkdir registry/default/lib
#cp -r .tmp/main/plate-main/apps/www/src/registry/default/lib/* registry/default/lib

mkdir registry/default/components
mkdir registry/default/components/editor
cp -r .tmp/main/plate-main/apps/www/src/registry/default/components/editor/* registry/default/components/editor

mkdir registry/default/hooks
cp -r .tmp/main/plate-main/apps/www/src/registry/default/hooks/* registry/default/hooks

# Cleanup unwanted content
rm registry/default/plate-ui/ai-menu.tsx
rm registry/default/plate-ui/slash-input-element.tsx
rm registry/default/plate-ui/code-*.tsx
rm registry/default/plate-ui/calendar.tsx
rm registry/default/plate-ui/date-element.tsx
rm registry/default/plate-ui/export-toolbar-button.tsx
rm registry/default/plate-ui/fixed-toolbar-buttons.tsx
rm registry/default/plate-ui/ai-chat-editor.tsx
rm registry/default/plate-ui/fixed-toolbar-list-buttons.tsx
rm registry/default/plate-ui/form.tsx
rm registry/default/plate-ui/import-toolbar-button.tsx
rm registry/default/plate-ui/select-editor.tsx
rm registry/default/plate-ui/remote-cursor-overlay.tsx
rm registry/default/plate-ui/media-placeholder-element.tsx
rm registry/default/plate-ui/media-video-element.tsx
rm registry/default/plate-ui/media-upload-toast.tsx
rm registry/default/plate-ui/media-toolbar-button.tsx

rm registry/default/components/editor/settings.tsx
rm registry/default/components/editor/use-chat.ts
rm registry/default/components/editor/use-create-editor.ts
rm registry/default/components/editor/use-create-editor-list.ts
rm registry/default/components/editor/slate-to-html.tsx

rm registry/default/components/editor/plugins/ai-plugins.tsx
rm registry/default/components/editor/plugins/editor-plugins.tsx
rm registry/default/components/editor/plugins/fixed-toolbar-plugin.tsx
rm registry/default/components/editor/plugins/fixed-toolbar-list-plugin.tsx
rm registry/default/components/editor/plugins/tabbable-plugin.ts
rm registry/default/components/editor/plugins/soft-break-plugin.ts
rm registry/default/components/editor/plugins/exit-break-plugin.ts
rm registry/default/components/editor/plugins/media-plugins.tsx

#rm registry/default/components/editor/plugins/ai-plugins.tsx
#rm registry/default/components/editor/plugins/copilot-plugins.ts
#rm registry/default/components/editor/plugins/editor-plugins.tsx

# Fix sources
#sed -i 's/.\/ai-toolbar-button/.\/ai-toolbar-button.js/' registry/default/plate-ui/*
#sed -i 's/.\/comment-toolbar-button/.\/comment-toolbar-button.js/' registry/default/plate-ui/*
#sed -i 's/.\/mark-toolbar-button/.\/mark-toolbar-button.js/' registry/default/plate-ui/*
#sed -i 's/.\/link-toolbar-button/.\/link-toolbar-button.js/' registry/default/plate-ui/*
#sed -i 's/.\/more-dropdown-menu/.\/more-dropdown-menu.js/' registry/default/plate-ui/*
#sed -i 's/.\/toolbar/.\/toolbar.js/' registry/default/plate-ui/*
#sed -i 's/.\/tooltip/.\/tooltip.js/' registry/default/plate-ui/*
#sed -i "s/.\/button'/.\/button.js'/" registry/default/plate-ui/*
#sed -i 's/.\/plate-element/.\/plate-element.js/' registry/default/plate-ui/*
#sed -i 's/.\/draggable/.\/draggable.js/' registry/default/plate-ui/*
#sed -i 's/\/components\/editor\/transforms/\/components\/editor\/transforms.js/' registry/default/plate-ui/*
#sed -i 's/.\/dropdown-menu/.\/dropdown-menu.js/' registry/default/plate-ui/*
#sed -i 's/.\/turn-into-dropdown-menu/.\/turn-into-dropdown-menu.js/' registry/default/plate-ui/*
#sed -i "s/.\/separator'/.\/separator.js'/" registry/default/plate-ui/*
#sed -i "s/.\/checkbox'/.\/checkbox.js'/" registry/default/plate-ui/*
#sed -i "s/.\/popover'/.\/popover.js'/" registry/default/plate-ui/*
#sed -i "s/.\/resizable'/.\/resizable.js'/" registry/default/plate-ui/*
#sed -i "s/.\/block-selection'/.\/block-selection.js'/" registry/default/plate-ui/*
#sed -i "s/.\/inline-combobox'/.\/inline-combobox.js'/" registry/default/plate-ui/*
#sed -i "s/\.\/hooks\/use-mounted'/.\/hooks\/use-mounted.js'/g" registry/default/plate-ui/*
#sed -i "s/.\/input'/.\/input.js'/" registry/default/plate-ui/*
#sed -i "s/.\/caption'/.\/caption.js'/" registry/default/plate-ui/*
#sed -i "s/.\/media-popover'/.\/media-popover.js'/" registry/default/plate-ui/*
#sed -i "s/.\/toggle-toolbar-button'/.\/toggle-toolbar-button.js'/" registry/default/plate-ui/*
#sed -i "s/.\/table-dropdown-menu'/.\/table-dropdown-menu.js'/" registry/default/plate-ui/*
#sed -i "s/.\/mode-dropdown-menu'/.\/mode-dropdown-menu.js'/" registry/default/plate-ui/*
#sed -i "s/.\/media-toolbar-button'/.\/media-toolbar-button.js'/" registry/default/plate-ui/*
#sed -i "s/.\/list-toolbar-button'/.\/list-toolbar-button.js'/" registry/default/plate-ui/*

#sed -i 's/@\/registry\/default\/lib\//..\/lib\//' registry/default/plate-ui/*
sed -i 's/@\/registry\/default\/plate-ui\//..\/..\/..\/plate-ui\//' registry/default/components/editor/plugins/*
sed -i 's/@\/registry\/default\/hooks\//..\/hooks\//' registry/default/plate-ui/*
sed -i 's/@\/registry\/default\/components\//..\/components\//' registry/default/plate-ui/*
sed -i 's/export const CaptionTextarea = withCn/export const CaptionTextarea: typeof CaptionTextareaPrimitive = withCn/' registry/default/plate-ui/caption.tsx
sed -i 's/useEffect(() => {/useEffect(() => {\n    \/\/ @ts-ignore/' registry/default/hooks/use-debounce.ts

# Add changes to git
git add registry/.

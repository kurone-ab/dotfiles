#!/bin/bash
find ~/Library/Application\ Support/JetBrains/IntelliJIdea*/plugins/*/lib -name "*.jar" -exec unzip -p {} META-INF/plugin.xml \; 2>/dev/null | rg -oP '(?<=<id>)[^<]+' | sort -u > plugins.txt

#!/bin/sh
rubocop -A
npx stylelint "**/*.{css,scss}" --fix --custom-syntax postcss-scss
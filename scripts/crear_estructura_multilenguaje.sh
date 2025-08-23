#!/bin/bash
langs=("es" "en" "fr" "pt")
for lang in "${langs[@]}"; do
  hugo new "$lang/_index.md" --kind home
  hugo new "$lang/about.md"
  hugo new "$lang/contact.md"
done

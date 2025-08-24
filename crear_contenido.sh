#!/bin/bash

# --- Configuración ---
# Lista de idiomas (basado en tus carpetas)
languages=("es" "en" "fr" "pt")
# Secciones a crear (basado en tu menú)
sections=("posts" "about")
# Número de posts de ejemplo a crear en la sección "posts"
num_posts=3

echo "--- Iniciando la creación de contenido de prueba ---"

# Bucle por cada idioma
for lang in "${languages[@]}"; do
    echo "Procesando idioma: $lang"

    # Crear una página "about" para el idioma
    ABOUT_PATH="content/$lang/about.md"
    echo "Creando página 'about' en: $ABOUT_PATH"
    # Usamos -p para asegurarnos de que el directorio padre exista
    mkdir -p "$(dirname "$ABOUT_PATH")"
    
    # Títulos y contenido traducidos para la página "about"
    about_title="Sobre Mí"
    about_content="Esta es la página sobre mí."
    if [ "$lang" == "en" ]; then
        about_title="About Me"
        about_content="This is the about me page."
    elif [ "$lang" == "fr" ]; then
        about_title="À Propos de Moi"
        about_content="Ceci est la page à propos de moi."
    elif [ "$lang" == "pt" ]; then
        about_title="Sobre Mim"
        about_content="Esta é a página sobre mim."
    fi

    # Escribir el contenido en el archivo de la página "about"
    cat << EOF > "$ABOUT_PATH"
---
title: "$about_title"
date: $(date -u +%Y-%m-%dT%H:%M:%SZ)
draft: false
---

$about_content

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
EOF

    # Crear posts de ejemplo para la sección "posts"
    POSTS_PATH="content/$lang/posts"
    echo "Creando $num_posts posts en: $POSTS_PATH"
    mkdir -p "$POSTS_PATH"

    for i in $(seq 1 $num_posts); do
        # Tags y títulos traducidos
        post_title="Artículo de Ejemplo $i"
        tags=("noticias" "tecnología")
        if [ "$lang" == "en" ]; then
            post_title="Sample Post $i"
            tags=("news" "technology")
        elif [ "$lang" == "fr" ]; then
            post_title="Article d'Exemple $i"
            tags=("actualités" "technologie")
        elif [ "$lang" == "pt" ]; then
            post_title="Post de Exemplo $i"
            tags=("notícias" "tecnologia")
        fi
        
        # Escribir el contenido en el archivo del post
        cat << EOF > "$POSTS_PATH/post-ejemplo-$i.md"
---
title: "$post_title"
date: $(date -u +%Y-%m-%dT%H:%M:%SZ)
author: "Javier Caram"
tags: ["${tags[0]}", "${tags[1]}"]
draft: false
---

## Introducción

Este es el cuerpo del **$post_title** en *$lang*.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
EOF
    done
    echo "----------------------------------------"
done

echo "--- Proceso completado. ---"
echo "Ejecuta 'hugo server' para ver los cambios."
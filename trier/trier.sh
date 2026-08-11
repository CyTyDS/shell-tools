#!/bin/bash

# Nom du script pour l'exclure du tri
SCRIPT_NAME=$(basename "$0")

# Dossier à trier (par défaut le dossier courant si aucun argument n'est passé)
TARGET_DIR="${1:-.}"

cd "$TARGET_DIR" || exit

# On boucle sur chaque fichier du dossier
for fichier in *; do
    # On vérifie que c'est bien un fichier (pas un dossier)
    if [ -f "$fichier" ] && [ "$fichier" != "$SCRIPT_NAME" ]; then
        # Extraction de l'extension et conversion en minuscules
        ext="${fichier##*.}"
        ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

        case "$ext_lower" in
            jpg|jpeg|png|gif|svg)
                dossier="Images"
                ;;
            pdf|doc|docx|txt|xlsx|pptx)
                dossier="Documents"
                ;;
            exe|msi|dmg|app)
                dossier="Logiciels"
                ;;
            mp4|mkv|mov|avi)
                dossier="Videos"
                ;;
            zip|rar|tar|gz|7z)
                dossier="Archives"
                ;;
            json|xml|csv)
                dossier="Data"
                ;;
            *)
                dossier="Autres"
                ;;
        esac

        # Création du dossier si nécessaire et déplacement
        mkdir -p "$dossier"
        mv "$fichier" "$dossier/"
        echo "Déplacé : $fichier -> $dossier/"
    fi
done

echo "Tri terminé !"
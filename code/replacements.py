import os
import sys


def replacements(racine_html):
    assert os.path.exists(racine_html), f"Path do not exist {racine_html!r}"
    ancien = os.environ.get("HOME", "")
    nouveau = "~"

    for dossier, _, fichiers in os.walk(racine_html):
        for fichier in fichiers:
            if fichier.endswith(".html"):
                chemin = os.path.join(dossier, fichier)
                with open(chemin, "r", encoding="utf-8") as f:
                    contenu = f.read()
                if ancien in contenu:
                    print(f"replace in {chemin}")
                    contenu = contenu.replace(ancien, nouveau)
                    with open(chemin, "w", encoding="utf-8") as f:
                        f.write(contenu)


if __name__ == "__main__":
    replacements(sys.argv[-1])

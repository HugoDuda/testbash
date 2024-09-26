# TestBash
Bienvenue dans **TestBash**, un ensemble de tests fonctionnels en bash. Ce projet contient un dossier `bashtest` et un exécutable `test.sh` à la racine du projet.

## Lancer les tests
Pour lancer la moulinette de tests, assurez-vous de bien configurer les permissions d'exécution et utilisez la commande suivante :
```bash
chmod 755 test.sh
./test.sh
```

## Remarques importantes
Projet **Setting Up** : Placez votre fichier exemple_files dans la racine de votre projet pour que les tests puissent s'exécuter correctement.
Projet **Organised** : Il est possible que certains tests échouent en raison de différences dans l'ordre d'affichage. Cela peut se produire si vous gérez votre liste chaînée par le début ou par la fin. Assurez-vous de vérifier si c'est bien le problème rencontrer avec une redirection du test en question dans un fichier par exemple.

## Structure du projet
Les tests se compose des éléments suivants :
**bashtest/** : Dossier contenant les tests.
**test.sh** : Script pour exécuter tous les tests.

## Utilisation
Pour utiliser ce script de tests, suivez les étapes ci-dessous :
Clonez ce repository dans la racine de votre projet en utilisant la commande suivante :
```bash
git clone <URL_DU_REPOSITORY>
```
Mettez ensuite tout les éléments à la racine de votre projet (L'endroit du Makefile qui compile le projet)
Lancer le script test.sh après avoir donné les permissions d'exécution :
```bash
chmod 755 test.sh
./test.sh
```

## Contribution
Si vous souhaitez contribuer à ce projet ou si vous avez des suggestions d'amélioration, n'hésitez pas à ouvrir une issue ou à soumettre une pull request.


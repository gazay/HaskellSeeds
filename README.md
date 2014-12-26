HaskellSeeds
============

Small program which will help you to build and publish your library to hackage easy way

## Install

```bash
cabal install seed
```

## Configuration

Before build and upload your library to hackage you can initialize configutation file
for HaskellSeeds.

```bash
$> seed config
Enter your username on Hackage:
$> gazay
Enter your password:
$>
Enter location for configuration file (Press enter for ~/.HaskellSeeds):
$>
```

## Usage:

```bash
$> seed build yourLib.cabal
Seed was successfully built
Documentation was successfully compiled

$>

$> seed push dist/yourLib-0.1.0.0.tar.gz
Seed was successfully uploaded
Documentation was successfully uploaded
You can check your library documentation on http://hackage.haskell.org/package/yourLib

$>
```

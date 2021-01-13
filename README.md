#  FightCamp Homework
## Evan Templeton

# Technical Decisions
## MainViewController
Contains `ScrollView` and `StackView`, which contain `PackageViewController` Child Views
Receives `[Package]` list from `PackageViewModel` and populates `PackageViewController`s

## PackageViewController
Structure for each FightCamp Package

## PackageViewModel
Logic for fetching and retreiving `Package` objects
Sends `[Package]` list to `MainViewController`

## Package API
Logic for parsing `packages.json`, returns an array of `Package` objects

## Models
`Struct`s for interacting with `packages.json`

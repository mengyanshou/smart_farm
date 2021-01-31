rm -rf migrations/00000001_initial.migration.dart
aqueduct db generate
pub run aqueduct db upgrade
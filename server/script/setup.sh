rm -rf migrations/00000001_initial.migration.dart
pub run aqueduct db generate
pub run aqueduct db upgrade
pub run aqueduct auth add-client \
  --id com.nightmare.termare \
  --secret com.nightmare
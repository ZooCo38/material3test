enum ExportFormat {
  json('JSON', 'json'),
  dart('Dart', 'dart'),
  xml('XML', 'xml');

  final String label;
  final String extension;

  const ExportFormat(this.label, this.extension);
}
import 'dart:io';

void main() {
  final directory = Directory('lib');
  final output = File('project_dump.txt').openWrite();

  void writeFiles(Directory dir) {
    for (var entity in dir.listSync(recursive: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        output.writeln('==== FILE: ${entity.path} ====');
        output.writeln(entity.readAsStringSync());
        output.writeln('\n');
      } else if (entity is Directory) {
        writeFiles(entity);
      }
    }
  }

  writeFiles(directory);
  output.close();
}

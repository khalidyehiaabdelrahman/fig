import 'dart:io';

void main() {
  final libDir = Directory('lib'); // مسار مجلد lib
  if (!libDir.existsSync()) {
    print('مجلد lib مش موجود!');
    return;
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .where((f) => f is File && f.path.endsWith('.dart'));

  final lineComment = RegExp(r'//.*'); // كومنت سطر واحد
  final blockComment = RegExp(r'/\*[\s\S]*?\*/'); // كومنت متعدد الأسطر

  for (var file in dartFiles) {
    final f = file as File;
    final content = f.readAsStringSync();
    final cleaned = content
        .replaceAll(blockComment, '')
        .replaceAll(lineComment, '');
    f.writeAsStringSync(cleaned);
    print('تم تنظيف الملف: ${f.path}');
  }

  print('تم مسح كل الكومنتات من مجلد lib بنجاح!');
}

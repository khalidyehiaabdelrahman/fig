import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit(String initialLang) : super(initialLang);

  void selectLanguage(String languageCode) {
    emit(languageCode);
  }
}

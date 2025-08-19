import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit(super.initialLang);

  void selectLanguage(String languageCode) {
    emit(languageCode);
  }
}

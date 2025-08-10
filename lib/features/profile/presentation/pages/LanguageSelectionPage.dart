import 'package:fig/core/constants/components.dart';
import 'package:fig/core/utils/responsive.dart';
import 'package:fig/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/language_cubit.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang = context.locale.languageCode;

    return BlocProvider(
      create: (_) => LanguageCubit(currentLang),
      child: Scaffold(
        appBar: AppBar(title: Text('select_language'.tr())),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    color: Colors.grey.shade400,
                    child: Text(
                      'Egypt'.tr(),
                      style: TextStyle(
                        fontSize: 20.rt(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildLanguageTile(context, 'en', 'English'),
                  buildReusableDivider(),
                  _buildLanguageTile(context, 'ar', 'العربية'),
                  buildReusableDivider(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<LanguageCubit, String>(
                builder: (context, selectedLangCode) {
                  return PrimaryButton(
                    label: 'apply'.tr(),
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    onPressed: () {
                      context.setLocale(Locale(selectedLangCode));
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    String languageCode,
    String label,
  ) {
    return BlocBuilder<LanguageCubit, String>(
      builder: (context, selectedLangCode) {
        final isSelected = selectedLangCode == languageCode;

        return InkWell(
          onTap: () {
            context.read<LanguageCubit>().selectLanguage(languageCode);
            context.setLocale(Locale(languageCode));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: const TextStyle(fontSize: 18)),
                isSelected
                    ? Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD32F2F),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    )
                    : Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

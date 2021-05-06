// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../../../main_viewmodel.dart';
import '../../../utils/shared_pref.dart';
import '../../presentation.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainVM = Provider.of<MainViewModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: WidgetAppBar(title: 'choose_language'.tr),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'vietnamese'.tr,
                style: theme.textTheme.subtitle1,
              ),
              onTap: () {
                mainVM.language = Language.vietnamese;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'english'.tr,
                style: theme.textTheme.subtitle1,
              ),
              onTap: () {
                mainVM.language = Language.english;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
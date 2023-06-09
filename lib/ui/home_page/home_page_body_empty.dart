import 'package:flutter/material.dart';

import 'package:neuropathy_grading_tool/ui/examination/examination_page.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:neuropathy_grading_tool/ui/widgets/add_examination_button.dart';

/// The body of the [HomePage] when there are no completed examinations.
/// Displays a welcome message and a button to add a new examination.
class HomePageEmptyResults extends StatelessWidget {
  const HomePageEmptyResults({Key? key}) : super(key: key);

  Widget slideTransition(animation, child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.ease)).animate(animation),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Languages.of(context)!.translate('welcome-screen.welcome'),
              style: AppTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            Text(
              Languages.of(context)!.translate('welcome-screen.no-completed'),
              style: AppTextStyle.headline24sp.copyWith(
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpacing(48),
            GestureDetector(
              onTap: () => Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => ExaminationPage(),
                transitionDuration: const Duration(milliseconds: 350),
                transitionsBuilder: (_, animation, __, child) =>
                    slideTransition(animation, child),
              )),
              child: Text(
                Languages.of(context)!.translate('welcome-screen.tap-to-start'),
                style: AppTextStyle.headline24sp.copyWith(
                  height: 1.25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpacing(24),
            const AddExaminationButton()
          ],
        ),
      ),
    );
  }
}

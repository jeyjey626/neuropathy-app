import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/utils/calculate_score.dart';
import 'package:neuropathy_grading_tool/repositories/settings_repository/patient.dart';
import 'package:neuropathy_grading_tool/examination/sections/free_text_part.dart';
import 'package:neuropathy_grading_tool/examination/step_identifiers.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/comments_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/other_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/pain_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/pin_prick_tile.dart';
import 'package:neuropathy_grading_tool/ui/results/tiles/vibration_tile.dart';
import 'package:neuropathy_grading_tool/ui/widgets/download_examination_icon.dart';

import 'package:neuropathy_grading_tool/utils/neuropathy_icons.dart';
import 'package:neuropathy_grading_tool/ui/widgets/date_formatter.dart';
import 'package:neuropathy_grading_tool/ui/widgets/spacing.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

/// Detailed results display page for a single [task] at a time.
///
/// The [AppBar] contains a download and close actions.
/// Date and examination score are displayed as tiles.
/// Every section has an [ExpansionTile] that contains its results.
/// Multiple tiles can be open at the same time.
/// All of the elements are displayed as a ```Column``` wrapped in ```SingleChildScrollView```
class DetailedResultPage extends StatelessWidget {
  const DetailedResultPage(
      {Key? key, required this.result, required this.patient})
      : super(key: key);
  final RPTaskResult result;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Languages.of(context)!.translate('results.title').toUpperCase(),
            style: AppTextStyle.extraLightIBM16sp.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: DownloadExaminationIcon(results: [result], patient: patient),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
                title: FormattedDateText(
                    dateTime: result.startDate!,
                    style: AppTextStyle.regularIBM20sp),
                subtitle: Text(
                  Languages.of(context)!.translate('results.date'),
                  style: AppTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  NeuropathyIcons.carbon_result,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            ListTile(
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: calculateScore(result).toString(),
                        style: AppTextStyle.regularIBM20sp),
                    TextSpan(
                        text:
                            ' (${Languages.of(context)!.translate('results.out-of')} 44)',
                        style: AppTextStyle.extraLightIBM16sp)
                  ]),
                ),
                subtitle: Text(
                  Languages.of(context)!.translate('results.score'),
                  style: AppTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  NeuropathyIcons.maki_doctor,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            PinPrickTile(result: result),
            VibrationTile(result: result),
            OtherFindingsTile(taskResult: result),
            if (result.results.keys
                .any((element) => painStepIdentifiers.contains(element)))
              PainTile(taskResult: result),
            if (result.results.keys
                    .any((element) => element == freeTextStep.identifier) &&
                result.results.entries
                        .where(
                            (element) => element.key == freeTextStep.identifier)
                        .map((e) => e.value as RPStepResult)
                        .first
                        .results['answer'] !=
                    null)
              CommentsExpansionTile(
                  text: result.results.entries
                      .where(
                          (element) => element.key == freeTextStep.identifier)
                      .map((e) => e.value as RPStepResult)
                      .first
                      .results['answer']),
            verticalSpacing(16)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:neuro_planner/repositories/result_repository/examination_score.dart';
import 'package:neuro_planner/survey/vibration_part.dart';
import 'package:neuro_planner/ui/results/panels/panel_item.dart';
import 'package:neuro_planner/ui/results/panels/pin_prick_tile.dart';
import 'package:neuro_planner/ui/results/panels/vibration_panel.dart';
import 'package:neuro_planner/ui/results/results_panel_list.dart';
import 'package:neuro_planner/utils/date_formatter.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

import '../../utils/generate_csv.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, required this.result}) : super(key: key);
  final RPTaskResult result;

  @override
  Widget build(BuildContext context) {
    Map<String, int> vibrationScores = Map.fromEntries(result.results.values
        .cast<RPStepResult>()
        .toList()
        .where(
            (element) => allVibrationIdentifiers.contains(element.identifier))
        .map((e) =>
            MapEntry(e.identifier, e.results['answer'][0]['value'] as int)));
    return Scaffold(
      appBar: AppBar(
        title: Text('examination result'.toUpperCase(),
            style: ThemeTextStyle.extraLightIBM16sp.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.download_outlined),
          onPressed: () {
            CsvData csvData = CsvData.fromResults([result]);
            exportCSV.myCSV(csvData.headers, csvData.rows);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: <Color>[
        //         Theme.of(context).colorScheme.primary,
        //         //Colors.white54,
        //         Theme.of(context).colorScheme.background,
        //       ],
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
                title: DateFormatter(
                    dateTime: result.startDate!,
                    style: ThemeTextStyle.regularIBM20sp),
                subtitle: Text(
                  'Examination date',
                  style: ThemeTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  Icons.calendar_month,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            ListTile(
                title: Text(
                  calculateScore(result).toString(),
                  style: ThemeTextStyle.regularIBM20sp,
                ),
                subtitle: Text(
                  'Total score',
                  style: ThemeTextStyle.extraLightIBM16sp,
                ),
                leading: Icon(
                  Icons.thermostat,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                )),
            PinPrickTile(result: result),
            ExpansionTile(
                title: Text('Vibration', style: ThemeTextStyle.regularIBM20sp),
                leading: Icon(
                  Icons.vibration,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: [
                  VibrationPanelBody(vibrationScores: vibrationScores),
                ]),
          ],
        ),
      ),
    );
  }
}
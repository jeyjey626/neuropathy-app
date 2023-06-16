import 'package:neuro_planner/repositories/result_repository/examination_score.dart';
import 'package:neuro_planner/survey/free_text_part.dart';
import 'package:neuro_planner/survey/step_identifiers.dart';
import 'package:research_package/research_package.dart';
import '../repositories/settings_repository/patient.dart';

List<String> csvHeaders = [
  "timestamp",
  "sex",
  "age",
  "result",
  ...gradingTaskIdentifiers,
  freeTextStep.identifier,
  ...painStepIdentifiers
];

class CsvData {
  final List<String> headers;
  final List<List<String>> rows;
  CsvData(this.headers, this.rows);

  CsvData.fromResults(List<RPTaskResult> results, Patient? patient)
      : headers = csvHeaders,
        rows = [
          csvHeaders,
          ...results.map((e) => resultToCsvRow(e, patient)).toList()
        ];
}

List<String> resultToCsvRow(RPTaskResult result, Patient? patient) {
  Map<String, String> rowMap = csvHeaders
      .asMap()
      .map((e, v) => MapEntry(v, _getCellValue(v, result, patient)));
  return rowMap.values.toList();
}

String _getCellValue(String header, RPTaskResult result, Patient? patient) {
  String res = "";
  List<RPStepResult> stepResults =
      result.results.values.cast<RPStepResult>().toList();
  switch (header) {
    case "timestamp":
      res = result.startDate?.toIso8601String() ?? "";
      break;
    case "sex":
      res = patient?.sex != null
          ? Sex.values
              .where((element) => element.value == patient!.sex)
              .first
              .exportText
          : "";
      break;
    case "age":
      res = patient?.dateOfBirth?.toIso8601String() ?? "";
      break;
    case "result":
      res = calculateScore(result).toString();
      break;
    case "pain1":
    case "pain2":
    case "pain3":
      {
        res = "";
        break;
      }
    case "free_text_step":
      {
        var val = stepResults
            .firstWhere((element) => element.identifier == header)
            .results['answer'];
        res = val != null ? val[0]['value'].toString() : "";
        break;
      }
    case "painSlider":
      {
        res = stepResults
            .firstWhere((element) => element.identifier == header)
            .results['answer']
            .toString();
        break;
      }
    default:
      // TODO: switch case for different answer formats instead of the separate cases with identifiers
      {
        _getAnswerFormat(header, stepResults);
        if (stepResults.any((element) => element.identifier == header)) {
          res = stepResults
              .firstWhere((element) => element.identifier == header)
              .results['answer'][0]['value']
              .toString();
        } else {
          res = "";
        }
        break;
      }
  }
  return res;
}

void _getAnswerFormat(String header, List<RPStepResult> stepResults) {}

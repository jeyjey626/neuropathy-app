import 'package:json_annotation/json_annotation.dart';
import 'package:neuropathy_grading_tool/ui/examination/steps/rpui_free_text_step.dart';
import 'package:research_package/research_package.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class RPFreeTextStep extends RPStep {
  RPAnswerFormat answerFormat;

  RPFreeTextStep({
    required super.identifier,
    required super.title,
    super.text,
    super.optional,
    required this.answerFormat,
  });

  @override
  get stepWidget => RPUIFreeTextStep(this);
}

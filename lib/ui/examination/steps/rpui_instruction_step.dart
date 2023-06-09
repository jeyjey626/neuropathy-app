import 'package:flutter/material.dart';
import 'package:neuropathy_grading_tool/examination/steps/rp_instruction_step.dart';
import 'package:neuropathy_grading_tool/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';

import 'package:neuropathy_grading_tool/languages.dart';

class RPUIInstructionStepWithChildren extends StatelessWidget {
  final RPInstructionStepWithChildren step;

  const RPUIInstructionStepWithChildren({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    blocQuestion.sendReadyToProceed(true);
    List<Widget> children = step.instructionContent
        .map((e) => e is Text
            ? Text(Languages.of(context)!.translate(e.data.toString()),
                style: e.style, textAlign: e.textAlign)
            : e)
        .toList();
    return Material(
      textStyle: AppTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(Languages.of(context)!.translate(step.title),
                style: AppTextStyle.header1, textAlign: TextAlign.center),
            ...children
          ],
        ),
      ),
    );
  }
}

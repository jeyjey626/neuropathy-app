import 'package:flutter/material.dart';
import 'package:neuro_planner/step/steps/rp_instruction_step.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';

class RPUIInstructionStepWithChildren extends StatelessWidget {
  final RPInstructionStepWithChildren step;

  const RPUIInstructionStepWithChildren({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: ThemeTextStyle.headline24sp,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: step.instructionContent,
        ),
      ),
    );
  }
}

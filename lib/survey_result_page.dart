import 'package:flutter/material.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/utils/spacing.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SurveyResultPage extends StatelessWidget {
  SurveyResultPage({super.key, required this.result, required this.score});

  late final TaskResult result;
  late final int score;

  @override
  Widget build(BuildContext context) {
    double minScore = 0;
    double maxScore = 44;
    return Scaffold(
      body: Material(
        textStyle: ThemeTextStyle.headline24sp,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                verticalSpacing(72),
                Text(
                  Languages.of(context)!.translate('result-screen.title'),
                ),
                Column(
                  children: [
                    Text(Languages.of(context)!
                        .translate('result-screen.text-1')),
                    // A RadialGauge half-circle takes the space of a full circle, so we clip the bottom 30%
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.7,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: minScore,
                                  maximum: maxScore,
                                  startAngle: 180,
                                  endAngle: 0,
                                  showTicks: false,
                                  showLabels: false,
                                  radiusFactor: 0.8,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                        startValue: minScore,
                                        endValue: maxScore,
                                        startWidth: 30,
                                        endWidth: 30,
                                        gradient: const SweepGradient(
                                            colors: <Color>[
                                              Colors.green,
                                              Colors.yellow,
                                              Colors.red
                                            ],
                                            stops: <double>[
                                              0,
                                              0.5,
                                              1
                                            ]))
                                  ],
                                  pointers: <GaugePointer>[
                                    MarkerPointer(
                                      value: score.toDouble(),
                                      color: Colors.black,
                                      markerHeight: 20,
                                      markerWidth: 20,
                                      markerOffset: -0.15,
                                      enableAnimation: true,
                                      borderColor: Colors.black,
                                      offsetUnit: GaugeSizeUnit.factor,
                                    )
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        angle: 180,
                                        positionFactor: 0.9,
                                        verticalAlignment: GaugeAlignment.near,
                                        widget: Text('${minScore.toInt()}',
                                            style:
                                                const TextStyle(fontSize: 16))),
                                    GaugeAnnotation(
                                        angle: 0,
                                        positionFactor: 0.9,
                                        verticalAlignment: GaugeAlignment.near,
                                        widget: Text('${maxScore.toInt()}',
                                            style:
                                                const TextStyle(fontSize: 16)))
                                  ],
                                )
                              ],
                            ),
                            Text(
                              '${score.toInt()}',
                              style:
                                  ThemeTextStyle.header1.copyWith(fontSize: 60),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      Languages.of(context)!.translate('result-screen.text-2'),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpacing(24),
                    Text(
                      Languages.of(context)!.translate('result-screen.text-3'),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: (() {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    }),
                    child: Text(Languages.of(context)!
                        .translate('result-screen.button-main'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum TaskResult { unlikely, likely, probable }

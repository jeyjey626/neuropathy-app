import 'package:country_codes/country_codes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuro_planner/languages.dart';
import 'package:neuro_planner/repositories/result_repository/result_repository.dart';
import 'package:neuro_planner/repositories/settings_repository/settings_repository.dart';
import 'package:neuro_planner/ui/settings/tiles/age_settings_tile.dart';
import 'package:neuro_planner/ui/settings/tiles/export_data_settings_tile.dart';
import 'package:neuro_planner/ui/settings/tiles/language_settings_tile.dart';
import 'package:neuro_planner/ui/settings/tiles/reset_database_settings_tile.dart';
import 'package:neuro_planner/ui/settings/tiles/sex_settings_tile.dart';
import 'package:research_package/model.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../repositories/settings_repository/patient.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ResultRepository _resultRepository = GetIt.I.get();
  final SettingsRepository _settingsRepository = GetIt.I.get();
  List<RPTaskResult> _results = [];
  Patient? _patient;
  bool willReload = false;

  _loadResults() async {
    final results = await Future.delayed(
        const Duration(seconds: 1), () => _resultRepository.getResults());
    setState(() => _results = results);
  }

  _setPatient(Patient patient) async {
    await _settingsRepository.insertPatientInfo(patient);
    _getPatient();
  }

  _getPatient() async {
    final patient = await _settingsRepository.getPatientInformation();
    setState(() => _patient = patient);
  }

  _changePatientInfo(Map<String, dynamic> newValue) async {
    await _settingsRepository.changePatientInfo(newValue);
    _getPatient();
  }

  _resetDatabase() async {
    await _resultRepository.deleteAllResults();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _getPatient();
    _loadResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shouldReload() {
      setState(() {
        willReload = true;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context, willReload),
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SettingsList(sections: [
          SettingsSection(
            title: Text(Languages.of(context)!
                .translate('settings.sections.personal-info')),
            tiles: [
              if (kDebugMode)
                SettingsTile(
                    title:
                        const Text('reset patient info w/out deleting results'),
                    onPressed: (_) => _setPatient(Patient())),
              SexSettingsTile(
                  patientSex: _patient?.sex,
                  onChanged: (newValue, reset) {
                    _changePatientInfo({'sex': newValue});
                    if (reset) _resetDatabase();
                    shouldReload();
                  }),
              AgeSettingsTile(_patient?.dateOfBirth,
                  (DateTime newValue, reset) {
                _changePatientInfo({'dateOfBirth': newValue.toIso8601String()});
                if (reset) _resetDatabase();
                shouldReload();
              })
            ],
          ),
          SettingsSection(
            title:
                Text(Languages.of(context)!.translate('settings.sections.app')),
            tiles: [
              const LanguagesSettingsTile(),
              ExportDataSettingTile(_results),
              ResetDatabaseSettingsTile(shouldReload()),
            ],
          ),
        ]));
  }
}
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neuropathy_grading_tool/languages.dart';
import 'package:neuropathy_grading_tool/repositories/result_repository/result_repository.dart';
import 'package:neuropathy_grading_tool/ui/widgets/confirm_operation_alert_dialog.dart';
import 'package:settings_ui/settings_ui.dart';

/// A settings tile for resetting the database. Allows to clear all the examination data.
///
/// When pressed, show a [ConfirmOperationAlertDialog] to confirm the operation.
/// It requires a callback [onShouldReload] to be passed as a parameter. It is called when the database is reset
/// and signals the parent widget to reload the data on pages that retrieve it.
class ResetDatabaseSettingsTile extends AbstractSettingsTile {
  final Function onShouldReload;
  const ResetDatabaseSettingsTile({required this.onShouldReload, super.key});

  @override
  Widget build(BuildContext context) {
    final ResultRepository resultRepository = GetIt.I.get();
    resetDatabase() async {
      await resultRepository.deleteAllResults();
    }

    return SettingsTile(
        title: Text(
          Languages.of(context)!.translate("settings.reset-database"),
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        leading: Icon(
          Icons.delete_forever,
          color: Theme.of(context).colorScheme.error,
        ),
        onPressed: (context) => showDialog<String>(
            context: context,
            builder: (BuildContext context) => ConfirmOperationAlertDialog(
                title: Languages.of(context)!
                    .translate('settings.delete-database.title'),
                content: Languages.of(context)!
                    .translate('settings.delete-database.text'),
                onConfirm: () {
                  resetDatabase();
                  onShouldReload();
                },
                confirmButtonChild: Text(
                    Languages.of(context)!
                        .translate('settings.delete-database.button-delete'),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error)))));
  }
}

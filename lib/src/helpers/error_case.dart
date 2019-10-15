import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ia_mobile/src/widgets/error_case_popup.dart';

errorCase(var error, BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ErrorCasePopup(
          context: context,
          errorMessage: error,
        );
      },
    );
  });
}

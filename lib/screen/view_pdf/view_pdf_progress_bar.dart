import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/view_pdf_bloc/view_pdf_progress_bar_bloc.dart';
import 'package:telemed_doc/component/modal_progress_bar/modal_progress_bar.dart';

class ViewPDFProgressBar extends StatelessWidget {
  final ViewPDFProgressBarBloc viewPDFProgressBarBloc;

  const ViewPDFProgressBar({Key key, this.viewPDFProgressBarBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: viewPDFProgressBarBloc.showProgress,
        builder: (context, snapshot) {
          return ModalProgressBar(
              inAsyncCall: viewPDFProgressBarBloc.showProgressValue,
              child: Container());
        });
  }
}

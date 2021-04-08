import 'package:rxdart/rxdart.dart';

class ViewPDFProgressBarBloc {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _filePath = BehaviorSubject<String>();
  final _isPreviewReady = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get showProgress => _showProgress.stream;
  Stream<String> get filePath => _filePath.stream;
  Stream<bool> get isPreviewReady => _isPreviewReady.stream;

  bool get showProgressValue => _showProgress.stream.value;
  String get filePathValue => _filePath.stream.value;
  bool get isPreviewReadyValue => _isPreviewReady.stream.value;

  Function(bool) get changeProgress => _showProgress.sink.add;
  Function(String) get changeFilePath => _filePath.sink.add;
  Function(bool) get changePreview => _isPreviewReady.sink.add;

  Future<void> getData(reportPDFUploadModel) async {
    changeProgress(true);
    changeFilePath(reportPDFUploadModel);
  }

  void dispose() {
    _isPreviewReady?.close();
    _filePath?.close();
    _showProgress?.close();
  }
}

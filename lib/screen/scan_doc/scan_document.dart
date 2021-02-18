import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:telemed_doc/util/constant.dart';

class ScanDocument extends StatefulWidget {
  @override
  _ScanDocumentState createState() => _ScanDocumentState();
}

class _ScanDocumentState extends State<ScanDocument> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  String _image;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  var _width;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Transform.scale(
                scale: _controller.value.aspectRatio / deviceRatio,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller), //cameraPreview
                  ),
                ));
          } else {
            return Center(
                child:
                    CircularProgressIndicator()); // Otherwise, display a loading indicator.
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.camera_alt),
            backgroundColor: BUTTON_BLUE,
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      imagePath: image?.path,
                    ),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  AppState state;
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.file(File(widget.imagePath)),
          _cropImage(File(widget.imagePath)),
        ],
      ),
    );
  }

  _cropImage(File file) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: widget.imagePath,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop the image',
            toolbarColor: BLUE,
            activeControlsWidgetColor: BLUE,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    setState(() {
      image = croppedFile;
    });
    if (image != null) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddMoreImage(
            image: image.path,
          ),
        ),
      );
    }
  }
}

class AddMoreImage extends StatefulWidget {
  final String image;

  const AddMoreImage({Key key, this.image}) : super(key: key);
  @override
  _AddMoreImageState createState() => _AddMoreImageState();
}

class _AddMoreImageState extends State<AddMoreImage> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    var index;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridTile(
          child: Card(
            child: Column(
              children: [
                Image.file(File(widget.image)),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ScanDocument();
                }));
              },
              child: Text(
                'Add more Pages',
                style: TextStyle(color: Colors.white),
              ),
              color: BUTTON_BLUE,
            ),
            SizedBox(
              width: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PDFMaker(image: imageFile.path);
                }));
              },
              child: Text(
                'Make PDF',
                style: TextStyle(color: Colors.white),
              ),
              color: BUTTON_BLUE,
            ),
          ],
        )
      ],
    ));
  }
}

class PDFMaker extends StatefulWidget {
  final String image;

  final String imageFile;

  const PDFMaker({Key key, this.image, this.imageFile}) : super(key: key);
  @override
  _PDFMakerState createState() => _PDFMakerState();
}

class _PDFMakerState extends State<PDFMaker> {
  var index;
  final pdf = pw.Document();
  // final String path = 'report.pdf';
  File imageFile;

  void initState() {
    main();
    super.initState();
  }

  Future main() async {
    final _img = PdfImage.file(pdf.document,
        bytes: File(widget.imageFile).readAsBytesSync());
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            // child: pw.Image(_img),
          );
        }));
    final output = await getExternalStorageDirectory();
    print("${output.path}/example.pdf");
    final file = File("${output.path}/Document$index.pdf");
    index = index + 1;
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Done"),
    );
  }
}

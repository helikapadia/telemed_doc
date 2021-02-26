import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class HomeUpload extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const HomeUpload({Key key, @required this.uploadDocumentsBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //stream: uploadDocumentsBloc.fileUrl,
        builder: (context, snapshot) {
      bool isEnabled = snapshot.data ?? false;
      return Card(
        child: Column(
          children: [
            FlatButton(
              onPressed: !isEnabled
                  ? () {
                      //uploadDocumentsBloc.selectPdf(context);
                      Navigator.pushNamed(context, UPLOAD_DETAIL_SCREEN);
                    }
                  : null,
              child: Text(
                'Upload Documents',
                style: TextStyle(
                    fontFamily: 'Poppins', color: FONT_BLUE, fontSize: 14),
              ),
            ),
            Text(
              'from Gallery',
              style: TextStyle(
                  fontFamily: 'Poppins', color: FONT_BLUE, fontSize: 14),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/Upload- Scan.png',
                  height: 160,
                  width: 120,
                )
              ],
            )
          ],
        ),
      );
    });
  }
  // Future getPdfAndUpload() async{
  //   var rng = new Random();
  //   String randomName = "";
  //   for( var i=0; i<20; i++){
  //     print(rng.nextInt(100));
  //     randomName += rng.nextInt(100).toString();
  //   }
  //   FilePickerResult file = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //   );
  //   String fileName = '${randomName}.pdf',
  //   // savePdf(file.readAsBytesSync(), fileName);
  // };
  //
  // savePdf(List<int> asset, String name) async{
  //   StorageReference storage = FirebaseStorage.instance.ref().child(name) as StorageReference;
  //   StorageUploadTask uploadTask = storage.putFile
  // }
}

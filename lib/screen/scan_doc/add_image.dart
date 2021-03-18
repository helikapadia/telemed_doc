import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:telemed_doc/bloc/scan_bloc/scan_bloc.dart';

class AddImage extends StatelessWidget {
  final ScanBloc scanBloc;

  const AddImage({Key key, this.scanBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: scanBloc.imageSelectedFromCamera,
        builder: (context, snapshot) {
          return Column(
            children: [
              // Container(
              //   child: Text(
              //     'Add Attachment',
              //     style: TextStyle(
              //         color: FONT_BLUE, fontSize: 18, fontFamily: 'Poppins'),
              //   ),
              // ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        scanBloc.takePhotoFromCamera(context);
                        // if (Platform.isAndroid) {
                        //   _showBottomActionSheet(context);
                        // }
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 35),
                          child: Card(
                            color: Colors.grey.shade300,
                            elevation: 0,
                            child: Center(
                              child: Icon(
                                Icons.upload_file,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          if (scanBloc.photoSelected[index].isFromLib)
                            InkWell(
                              child: AssetThumb(
                                asset: scanBloc.photoSelected[index].img,
                                width: MediaQuery.of(context).size.width ~/ 3,
                                height: 100,
                              ),
                            )
                          else
                            InkWell(
                              child: Image.file(
                                File(scanBloc.photoSelected[index].img),
                                width: MediaQuery.of(context).size.width / 3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Positioned(
                            top: -10,
                            right: -10,
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                scanBloc.photoSelected.removeAt(index);
                                scanBloc.imageSelectedFromCameraChanged(true);
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
                itemCount: scanBloc?.photoSelected?.length ?? 0,
              )
            ],
          );
        });
  }
}

// void _showBottomActionSheet(BuildContext context) {
//   showModalBottomSheet(
//       context: context,
//       backgroundColor: ALICE_BLUE,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//       isScrollControlled: true,
//       builder: (buildContext) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const SizedBox(
//                 height: 20,
//               ),
//               TextButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.camera_alt_outlined,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Text(
//                         'Take Picture from Camera',
//                         style: TextStyle(
//                             color: FONT_BLUE, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ))
//             ],
//           ),
//         );
//       });
// }

import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/upload_documents_bloc/upload_documents_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class AttachedReport extends StatelessWidget {
  final UploadDocumentsBloc uploadDocumentsBloc;

  const AttachedReport({Key key, this.uploadDocumentsBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: uploadDocumentsBloc.fileUrl,
      builder: (context, snapshot) {
        return uploadDocumentsBloc?.fileUrlValue?.isNotEmpty ?? false
            ? ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // Navigator.pushNamed(context, PDF_VIEW);
                    },
                    title: Text(
                      "attachment${index + 1}.pdf",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        uploadDocumentsBloc.deleteAddedReportPDF(
                            uploadDocumentsBloc.fileUrlValue[index]);
                      },
                    ),
                  );
                },
                itemCount: uploadDocumentsBloc?.fileUrlValue?.length)
            : Container();
      },
    );
  }
}

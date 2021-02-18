import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class SettingsBloc {
  final _authOn = BehaviorSubject<bool>.seeded(false);
  final _showProgress = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get authOn => _authOn.stream;
  Stream<bool> get showProgress => _showProgress.stream;

  bool get authOnValue => _authOn.stream.value;
  bool get showProgressValue => _showProgress.stream.value;

  Function(bool) get changeAuthOn => _authOn.sink.add;
  Function(bool) get changeProgress => _showProgress.sink.add;

  Future<void> setData() async {
    var userIdVal = FirebaseAuth.instance.currentUser.uid;
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection(USER_COLLECTION).doc(userIdVal);
    await documentReference.get().then((doc) async {
      if (doc.exists) {
        await documentReference
            .update({authStatusKey: authOnValue}).then((value) async {
          bool authValue = await AppPreference.getBoolF(authStatusKey);
          if (authValue != null) {
            changeAuthOn(authValue);
          }
        });
      }
    });
  }

  Future<void> updateAuthOn(BuildContext context, bool bioAuthValue) async {
    changeProgress(true);
    try {
      await AppPreference.setBool(authStatusKey, bioAuthValue);
      changeAuthOn(bioAuthValue);
      changeProgress(false);
    } on Exception catch (e) {
      changeProgress(false);
      changeAuthOn(!bioAuthValue);
      debugPrint(e.toString());
    }
  }

  void dispose() {
    _authOn?.close();
    _showProgress?.close();
  }
}

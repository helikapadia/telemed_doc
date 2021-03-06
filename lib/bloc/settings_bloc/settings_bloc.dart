import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/util/app_helper.dart';
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
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        FirebaseUser userIdVal = await FirebaseAuth.instance.currentUser();
        DocumentReference documentReference = Firestore.instance
            .collection(USER_COLLECTION)
            .document(userIdVal.uid);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            bool authValue = await AppPreference.getBoolF(authStatusKey);
            if (authValue != null) {
              changeAuthOn(authValue);
            }
            await documentReference
                .updateData({authStatusKey: authOnValue}).then((value) async {
              changeAuthOn(authValue);
              await AppPreference.setBool(authStatusKey, authOnValue);
            });
          }
        });
      }
    });
  }

  Future<void> updateAuthOn(BuildContext context, bool bioAuthValue) async {
    changeProgress(true);
    try {
      var userIdVal = FirebaseAuth.instance.currentUser();
      DocumentReference documentReference = Firestore.instance
          .collection(USER_COLLECTION)
          .document(userIdVal.toString());
      await documentReference.get().then((doc) async {
        if (doc.exists) {
          await documentReference
              .updateData({authStatusKey: authOnValue}).then((value) async {
            bool authValue = await AppPreference.getBoolF(authStatusKey);
            if (authValue != null) {
              changeAuthOn(authValue);
            }
            await AppPreference.setBool(authStatusKey, authOnValue);
          });
        }
      });
      // await AppPreference.setBool(authStatusKey, bioAuthValue);
      // changeAuthOn(bioAuthValue);
      // changeProgress(false);
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

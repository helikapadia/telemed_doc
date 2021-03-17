import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:telemed_doc/bloc/consulting_doctor_detail_bloc/consulting_doctor_detail_validators.dart';
import 'package:telemed_doc/util/app_helper.dart';
import 'package:telemed_doc/util/app_preference.dart';
import 'package:telemed_doc/util/constant.dart';

class ConsultingDoctorDetailBloc with ConsultingDoctorDetailValidators {
  final _showProgress = BehaviorSubject<bool>.seeded(false);
  final _doctorFullName = BehaviorSubject<String>();
  final _doctorSpecialization = BehaviorSubject<String>();
  final _doctorPhoneNumber = BehaviorSubject<String>();
  final _doctorAddress = BehaviorSubject<String>();

  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get doctorFullName =>
      _doctorFullName.stream.transform(fullNameValidator);
  Stream<String> get doctorSpecialization =>
      _doctorSpecialization.stream.transform(specializationValidator);
  Stream<String> get doctorPhoneNumber =>
      _doctorPhoneNumber.stream.transform(phoneNumberValidators);
  Stream<String> get doctorAddress =>
      _doctorAddress.stream.transform(addressValidators);

  bool get progressBarValue => _showProgress.stream.value;
  String get doctorFullNameValue => _doctorFullName.stream.value;
  String get doctorSpecializationValue => _doctorSpecialization.stream.value;
  String get doctorPhoneNumberValue => _doctorPhoneNumber.stream.value;
  String get doctorAddressValue => _doctorAddress.stream.value;

  Function(bool) get showProgress => _showProgress.sink.add;
  Function(String) get changeDoctorFullName => _doctorFullName.sink.add;
  Function(String) get changeDoctorSpecialization =>
      _doctorSpecialization.sink.add;
  Function(String) get changeDoctorPhoneNumber => _doctorPhoneNumber.sink.add;
  Function(String) get changeDoctorAddress => _doctorAddress.sink.add;

  Stream<bool> get submitDoctorDetails => Rx.combineLatest4(
      doctorFullName,
      doctorPhoneNumber,
      doctorSpecialization,
      doctorAddress,
      (fn, ph, sp, ad) => true);

  void addDoctorDetails(BuildContext context) async {
    hideKeyboard(context);
    showProgress(true);
    AppHelper.checkInternetConnection().then((isAvailable) async {
      if (isAvailable) {
        var userIdVal = FirebaseAuth.instance.currentUser.uid;
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(userIdVal);
        await documentReference.get().then((doc) async {
          if (doc.exists) {
            await documentReference.update({
              DOCTOR_NAME_KEY: doctorFullNameValue,
              DOCTOR_PHONE_NUMBER_KEY: doctorPhoneNumberValue,
              DOCTOR_SPECIALIZATION_KEY: doctorSpecializationValue,
              DOCTOR_ADDRESS_KEY: doctorAddressValue,
            }).then((value) async {
              showProgress(false);
              changeDoctorFullName(doctorFullNameValue);
              changeDoctorPhoneNumber(doctorPhoneNumberValue);
              changeDoctorSpecialization(doctorSpecializationValue);
              changeDoctorAddress(doctorAddressValue);
              await AppPreference.setString(
                  DOCTOR_NAME_KEY, doctorFullNameValue);
              await AppPreference.setString(
                  DOCTOR_PHONE_NUMBER_KEY, doctorPhoneNumberValue);
              await AppPreference.setString(
                  DOCTOR_SPECIALIZATION_KEY, doctorSpecializationValue);
              await AppPreference.setString(
                  DOCTOR_ADDRESS_KEY, doctorAddressValue);
              showDialogAndNavigate(DATA_ADDED_SUCCESSFULLY, context,
                  DAILY_MEDICINE_SCREEN_ROUTE);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          } else {
            await documentReference.set({
              DOCTOR_NAME_KEY: doctorFullNameValue,
              DOCTOR_PHONE_NUMBER_KEY: doctorPhoneNumberValue,
              DOCTOR_SPECIALIZATION_KEY: doctorSpecializationValue,
              DOCTOR_ADDRESS_KEY: doctorAddressValue,
            }).then((value) async {
              showProgress(false);
              changeDoctorFullName(doctorFullNameValue);
              changeDoctorPhoneNumber(doctorPhoneNumberValue);
              changeDoctorSpecialization(doctorSpecializationValue);
              changeDoctorAddress(doctorAddressValue);
              await AppPreference.setString(
                  DOCTOR_NAME_KEY, doctorFullNameValue);
              await AppPreference.setString(
                  DOCTOR_PHONE_NUMBER_KEY, doctorPhoneNumberValue);
              await AppPreference.setString(
                  DOCTOR_SPECIALIZATION_KEY, doctorSpecializationValue);
              await AppPreference.setString(
                  DOCTOR_ADDRESS_KEY, doctorAddressValue);
            }).catchError((errors) {
              showProgress(false);
              showMessageDialog(errors.msg, context);
            });
          }
        });
      } else {
        showProgress(false);
        showMessageDialog(PLEASE_CHECK_INTERNET_CONNECTION, context);
      }
    });
  }

  void dispose() {
    _doctorFullName?.close();
    _doctorAddress?.close();
    _doctorPhoneNumber?.close();
    _doctorSpecialization?.close();
    _showProgress?.close();
  }
}

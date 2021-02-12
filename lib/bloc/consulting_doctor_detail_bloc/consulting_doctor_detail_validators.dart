import 'dart:async';

import 'package:telemed_doc/util/constant.dart';

mixin ConsultingDoctorDetailValidators{
  StreamTransformer<String, String> fullNameValidator =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (fullName, sink) {
        if (fullName.length > 1) {
          sink.add(fullName);
        } else {
          sink.addError(FULL_NAME_ERROR);
        }
      });
  StreamTransformer<String, String> phoneNumberValidators =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNumber, sink) {
        if (phoneNumber.length > 4) {
          sink.add(phoneNumber);
        } else {
          sink.addError(PHONE_NUMBER_ERROR);
        }
      });
  StreamTransformer<String, String> specializationValidator =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (specializationValidator, sink) {
        if (specializationValidator.length > 1) {
          sink.add(specializationValidator);
        } else {
          sink.addError(SPECIALIZATION_ERROR);
        }
      });
  StreamTransformer<String, String> addressValidators =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (address, sink) {
        if (address.length > 1) {
          sink.add(address);
        } else {
          sink.addError(ADDRESS_ERROR);
        }
      });
}
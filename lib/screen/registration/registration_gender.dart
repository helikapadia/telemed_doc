import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/registration_bloc/registartion_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class RegistrationGender extends StatelessWidget {
  final RegistrationBloc registrationBloc;
  final FocusNode genderFocusNode;

  const RegistrationGender(
      {Key key,
      @required this.registrationBloc,
      @required this.genderFocusNode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: registrationBloc.gender,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    GENDER,
                    style: TextStyle(
                        color: FONT_BLUE, fontFamily: 'Poppins', fontSize: 18),
                  ),
                ),
                StreamBuilder<String>(
                    stream: registrationBloc.gender,
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Radio(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeColor: BLUE,
                            value: MALE,
                            groupValue:
                                registrationBloc?.genderValue ?? GENDER_KEY,
                            onChanged: changeGender,
                            focusNode: genderFocusNode,
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Radio(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeColor: BLUE,
                            value: FEMALE,
                            groupValue:
                                registrationBloc?.genderValue ?? GENDER_KEY,
                            onChanged: changeGender,
                            focusNode: genderFocusNode,
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      );
                    })
              ],
            ),
            // child: Card(
            //   elevation: 4,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 8),
            //     child: TextFormField(
            //       autocorrect: false,
            //       autofocus: true,
            //       enableSuggestions: true,
            //       keyboardType: TextInputType.text,
            //       textInputAction: TextInputAction.next,
            //       textAlign: TextAlign.start,
            //       onChanged: (value){
            //         registrationBloc?.genderChanged(value);
            //       },
            //       focusNode: genderFocusNode,
            //       decoration: InputDecoration(
            //         suffixIcon: !snapshot.hasError &&
            //             registrationBloc.genderValue != null
            //             ? Icon(
            //           Icons.check,
            //           color: Colors.green,
            //         )
            //             : null,
            //         fillColor: Colors.white,
            //         hintText: 'Gender',
            //         // enabledBorder: OutlineInputBorder(
            //         //   borderRadius: BorderRadius.all(Radius.circular(25)
            //         //   ),
            //         //   borderSide: BorderSide(color: Colors.grey.shade100,width: 2),
            //         // ),
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            // ),
          );
        });
  }

  void changeGender(String value) {
    value == MALE
        ? registrationBloc?.genderChanged(MALE)
        : registrationBloc?.genderChanged(FEMALE);
  }
}

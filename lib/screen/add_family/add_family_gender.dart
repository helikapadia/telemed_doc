import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/add_family_bloc/add_family_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class AddFamilyGender extends StatelessWidget {
  final FocusNode genderFocusNode;
  final AddFamilyBloc addFamilyBloc;

  const AddFamilyGender({Key key, this.genderFocusNode, this.addFamilyBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: addFamilyBloc.gender,
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
                    stream: addFamilyBloc.gender,
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
                            addFamilyBloc?.genderValue ?? FAM_GENDER_KEY,
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
                            addFamilyBloc?.genderValue ?? FAM_GENDER_KEY,
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
          );
        });
  }

  void changeGender(String value) {
    value == MALE
        ? addFamilyBloc?.genderChanged(MALE)
        : addFamilyBloc?.genderChanged(FEMALE);
  }
}

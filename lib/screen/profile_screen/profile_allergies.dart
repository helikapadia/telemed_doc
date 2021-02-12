import 'package:flutter/material.dart';
import 'package:telemed_doc/bloc/profile_bloc/profile_bloc.dart';
import 'package:telemed_doc/util/constant.dart';

class ProfileAllergies extends StatelessWidget {
  final ProfileBloc profileBloc;

  const ProfileAllergies({Key key,@required this.profileBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Icon(Icons.person),
          title: StreamBuilder<String>(
            stream: profileBloc.allergy,
            builder: (context, snapshot){
              return Text(
                profileBloc.allergyValue ?? "", style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
              );
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              _showBottomSheet(context);
            },
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: ALICE_BLUE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isScrollControlled: true,
        context: context,
        builder: (buildContext) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                ALLERGIES_KEY,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.grey
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(buildContext).viewInsets.bottom
                ),
                child: Wrap(
                  children: [
                    StreamBuilder<String>(
                        stream: profileBloc.allergy,
                        builder: (context, snapshot){
                          return TextFormField(
                            //initialValue: profileBloc.modalAllergyValue ?? "",
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onChanged: (value){
                              profileBloc.modalAllergyChanged(value);
                            },
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          );
                        }
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StreamBuilder<bool>(
                            stream: profileBloc.enableAllergySubmitCheck,
                            builder: (context, snapshot){
                              bool isEnabled = snapshot.data ?? false;
                              return FlatButton(
                                  onPressed: isEnabled ?(){
                                    profileBloc.updateAllergy(context);
                                  }: null,
                                  child: Text(SAVE, style: isEnabled ? TextStyle(
                                    fontFamily: 'Poppins',
                                  ): const TextStyle(color: Colors.grey),)
                              );
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}

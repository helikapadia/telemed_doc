import 'package:flutter/material.dart';

class UserProvider extends StatefulWidget {
  const UserProvider({@required this.child, this.userModel, Key key})
      : super(key: key);

  final Widget child;
  final UserModel userModel;

  @override
  UserProviderState createState() => UserProviderState();

  static UserProviderState of(BuildContext context) {
    InheritedUser inheritedUser =
    context.dependOnInheritedWidgetOfExactType<InheritedUser>();
    return inheritedUser.data;
  }
}

class UserProviderState extends State<UserProvider> {
  UserModel userModel;

  void updatedUser(String userId) {
    if (userModel == null) {
      setState(() {
        userModel = UserModel(userId: userId);
      });
    } else {
      setState(() {
        userModel..userId = userId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedUser(
      data: this,
      child: widget.child,
    );
  }
}

class InheritedUser extends InheritedWidget {
  const InheritedUser({@required this.data, @required Widget child, Key key})
      : super(key: key, child: child);

  final UserProviderState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class UserModel {
  UserModel({@required this.userId});

  String userId;
}

import 'package:flutter/material.dart';

class ResolveAuth extends StatefulWidget {
  @override
  _ResolveAuthState createState() => _ResolveAuthState();
}

class _ResolveAuthState extends State<ResolveAuth> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

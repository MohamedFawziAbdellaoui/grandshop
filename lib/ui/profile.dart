import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../models/user.dart';

class Profile extends StatefulWidget {
  User user;
  Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<bool> enabled = List.generate(5, (index) => false);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.red, Color(0xEEF44336)],
                      [Colors.redAccent, const Color(0x77E57373)],
                      [Colors.orange, Color(0x66FF9800)],
                      [Colors.yellow, Color(0x55FFEB3B)]
                    ],
                    durations: [35000, 19440, 10800, 6000],
                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    blur: MaskFilter.blur(BlurStyle.solid, 1),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(double.maxFinite,
                      MediaQuery.of(context).size.height * .2),
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: MediaQuery.of(context).size.width * .3,
                      backgroundImage: AssetImage("images/user-avatar.png"),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * .4,
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomTextField(
                        enabled: enabled[0],
                        initVal: widget.user.username!,
                        onSave: (value) {
                          widget.user.username = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[0] = true;
                          });
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[1],
                        enableControl: () {
                          setState(() {
                            enabled[1] = true;
                          });
                        },
                        initVal: widget.user.email!,
                        onSave: (value) {
                          widget.user.email = value!;
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[2],
                        initVal: widget.user.adress!,
                        onSave: (value) {
                          widget.user.adress = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[2] = true;
                          });
                        },
                      ),
                      CustomTextField(
                        enabled: enabled[3],
                        initVal: widget.user.password!,
                        onSave: (value) {
                          widget.user.password = value!;
                        },
                        enableControl: () {
                          setState(() {
                            enabled[3] = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Text(
                    "Save",
                  ),
                  onPressed: () {
                    formKey.currentState!.save();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.enabled,
    required this.onSave,
    required this.initVal,
    required this.enableControl,
  }) : super(key: key);
  final Function(String?) onSave;
  final bool enabled;
  VoidCallback enableControl;
  String initVal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .05,
            vertical: MediaQuery.of(context).size.height * .01,
          ),
          child: TextFormField(
            enabled: enabled,
            initialValue: initVal,
            onSaved: onSave,
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: enableControl,
        ),
      ],
    );
  }
}

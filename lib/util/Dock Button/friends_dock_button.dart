import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main.dart';
import 'package:flutter_application_1/util/Window%20Route/friends_window_route.dart';
import 'package:ionicons/ionicons.dart';

/*class SettingsDockButton extends StatefulWidget {
  SettingsDockButton({super.key, required this.icon, this.onPressed});
  IconData icon;
  VoidCallback? onPressed;
  @override
  State<SettingsDockButton> createState() => _SettingsDockButtonState();
}

class _SettingsDockButtonState extends State<SettingsDockButton> {
  Control control = Control.stop;
  Color activeColor = Colors.white;
  Color inactiveColor = Colors.white30;
  Color currentColor = Colors.white30;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tran,
      child: CustomAnimationBuilder<double>(
        control: control,
        startPosition: 0,
        tween: Tween(begin: 2, end: 1.5),
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear,
        onCompleted: () {
          reverseShrink();
        },
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: IconButton(
          icon: Icon(widget.icon),
          color: currentColor,
          onPressed: toggleShrink,
          highlightColor: tran,
          splashColor: tran,
        ),
      ),
    );
  }

  void toggleShrink() {
    // toggle between control instructions
    setState(() {
      control = Control.play;
      currentColor =
          (currentColor == activeColor) ? inactiveColor : activeColor;
    });
  }

  void reverseShrink() {
    setState(() {
      control = Control.playReverse;
    });
  }
}*/

class FriendsWindowButton extends StatelessWidget {
  /// {@macro add_todo_button}
  const FriendsWindowButton({super.key, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(FriendsWindowRoute(builder: (context) {
            return const _FriendsWindowPopupCard();
          }));
        },
        child: const Hero(
          tag: _heroFriendsWindow,
          /*createRectTween: (begin, end) {
            return Tween(begin: begin, end: end);
          },*/
          child: Material(
            color: tran,
            child: Icon(
              Ionicons.people,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroFriendsWindow = 'Friends-window-hero';

class _FriendsWindowPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _FriendsWindowPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroFriendsWindow,
          /*createRectTween: (begin, end) {
            return Tween(begin: begin, end: end);
          },*/
          child: Material(
            color: const Color(0xA9444444),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Friends',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

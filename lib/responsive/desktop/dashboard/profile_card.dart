import 'package:flutter_application_1/util/imports.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../../util/providers/userAuthProvider.dart';
import '../../../util/providers/userProvider.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import '../profile_popup/desk_profile_popup.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard(
      {super.key, this.height = 0, this.width = 0, required this.constraints});

  final double height;
  final double width;
  final BoxConstraints constraints;
  String adminOrUser = '';

  var userData = {};

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    userData = userProvider.userData;
    var token = userAuthProvider.token;
    // var decodedToken = JwtDecoder.decode(token);
    // final bool isAdmin = decodedToken["isAdmin"];
    // adminOrUser = isAdmin == true ? "Admin" : "User";

    return TactileButton(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              fullscreenDialog: false,
              transitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) {
                return Hero(
                  tag: 'profileHeroTag',
                  flightShuttleBuilder: flightShuttleBuilder,
                  child: Center(
                    child: ProfilePopup(),
                  ),
                );
              },
              transitionsBuilder: (_, anim, __, child) =>
                  FadeTransition(opacity: anim, child: child),
            ),
          );
        },
        child: BlurryContainer(
          width: width,
          height: height,
          constraints: constraints,
          color: deckBackgroundColor,
          padding:
              EdgeInsets.all(max(desktopContainerPadLowerLimit, 1.w(context))),
          borderRadius: max(cardBorderRadiusLowerLimit, 1.5.w(context)),
          child: Column(
            children: [
              Padding(
                // space between username and card slot
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userData["username"],
                    style: TextStyle(
                        fontSize: max(headerlowerlimit, 5.sp(context)),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //Expanded so this container expands to the available space in the profile card
              Expanded(
                  child: BlurryContainer(
                color: tran,
                padding: EdgeInsets.all(
                    max(desktopContainerPadLowerLimit, 1.w(context))),
                borderRadius: 1.5.w(context),
                child: SizedBox(),
              ))
            ],
          ),
        ));

    // child: Deck(
    //   deckHeight: deckHeight,
    //   deckWidth: halfDeckWidth,
    //   deckName: '',
    //   gradient1: tran,
    //   gradient2: tran,
    //   neonGlow: tran,
    //   labelTextSize: labelTextSize,
    //   headingText: userData["username"],
    //   headingTextSize: headingTextSize,
    //   subText: adminOrUser,
    // ));
  }
}

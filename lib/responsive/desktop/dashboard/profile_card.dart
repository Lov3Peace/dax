import 'package:flutter_application_1/util/imports.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../../util/providers/userAuthProvider.dart';
import '../../../util/providers/userProvider.dart';
import '../../../util/tactile_button.dart';
import '../desk_decks.dart';
import '../profile_popup/desk_profile_popup.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});

  String adminOrUser = '';

  var userData = {};

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    userData = userProvider.userData;
    var token = userAuthProvider.token;
    print("AuthNotifier Token: $token");
    var decodedToken = JwtDecoder.decode(token);
    print("AuthNotifier decodedToken: $decodedToken");
    final bool isAdmin = decodedToken["isAdmin"];
    adminOrUser = isAdmin == true ? "Admin" : "User";

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
          // width: 18.w(context),
          // height: 20.w(context),
          color: deckBackgroundColor,
          constraints: BoxConstraints(minWidth: 300, minHeight: 500),
          padding: 1.5.w(context),
          borderRadius: 2.w(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userData["username"],
                    style: TextStyle(
                        fontSize: 7.sp(context), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                  child: BlurryContainer(
                color: tran,
                borderRadius: 2.w(context),
                constraints: BoxConstraints(minWidth: 200),
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

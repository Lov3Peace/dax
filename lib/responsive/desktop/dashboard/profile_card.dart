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

    double deckHeight = 22.h(context);
    double halfDeckWidth = 17.325.w(context);
    double headingTextSize = 6.25.sp(context);
    subTextSize = 2.5.sp(context);
    double labelTextSize = 2.5.sp(context);
    if (100.w(context) < 1440) {
      headingTextSize = headingTextSize * 0.9;
    }
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
          width: 18.w(context),
          padding: 1.5.w(context),
          borderRadius: 2.w(context),
          child: Column(
            children: [
              Text(
                userData["username"],
                style: TextStyle(fontSize: 4.sp(context)),
              ),
              Expanded(
                  child: BlurryContainer(
                color: tran,
                borderRadius: 2.w(context),
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

import 'package:flutter_application_1/responsive/desktop/util/routes.dart';
import 'package:flutter_application_1/util/providers/userAuthProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: "/launch",
  redirect: (BuildContext context, GoRouterState state) {
    var userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    if (!userAuthProvider.isLoggedIn) {
      // Using PageRouteBuilder for smoother routing animation
      return "/launch";
    }
    if (userAuthProvider.isLoggedIn) {}
  },
  routes: <RouteBase>[
    GoRoute(
        path: "/launch",
        redirect: (BuildContext context, GoRouterState state) {
          var userAuthProvider =
              Provider.of<UserAuthProvider>(context, listen: false);
          if (userAuthProvider.isLoggedIn) {
            return "/";
          }
        },
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: LaunchPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        }),
    GoRoute(
      path: "/",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopDashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: "/projects",
      builder: (BuildContext context, state) => DesktopProjectsPage(),
      routes: [
        GoRoute(
          path: 'posts',
          builder: (BuildContext context, state) => DesktopProjectPostsPage(),
        ),
      ],
    ),
  ],
);

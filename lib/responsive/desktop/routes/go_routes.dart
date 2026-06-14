import 'package:flutter_application_1/responsive/desktop/dashboard/homeDashboard/desk_dashboard.dart';
import 'package:flutter_application_1/responsive/desktop/dashboard/projectDashboard/projectDashboard.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/communities/desk_hero_communities_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/desk_news_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/desk_socials_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/desktop_projects_page.dart';
import 'package:flutter_application_1/responsive/desktop/decks_content/projects/projectPostsPage.dart';
import 'package:flutter_application_1/responsive/desktop/util/error_page.dart';
import 'package:flutter_application_1/util/auth/launch_page.dart';
import 'package:flutter_application_1/util/providers/userAuthProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/main.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: "/launch",
  errorBuilder: (BuildContext context, GoRouterState state) {
    return ErrorPage();
  },
  redirect: (BuildContext context, GoRouterState state) {
    var userAuthProvider =
        Provider.of<UserAuthProvider>(context, listen: false);
    if (!userAuthProvider.isLoggedIn) {
      // Using PageRouteBuilder for smoother routing animation
      return "/launch";
    }
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
          print("GoRoutes Hostname Value: $hostname");
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
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopProjectsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          name: "category_posts",
          path: '/:category',
          pageBuilder: (context, state) {
            final parameter = state.pathParameters['category']!;
            return CustomTransitionPage(
              child: DesktopProjectPostsPage(parameter: parameter),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/socials",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopSocialsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          path: 'posts',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DesktopSocialsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/communities",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopCommunitiesPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          path: 'posts',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DesktopCommunitiesPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/news",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopNewsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
      routes: [
        GoRoute(
          path: 'posts',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: DesktopNewsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: "/projectDashboard",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: DesktopProjectDashboard(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
  ],
);

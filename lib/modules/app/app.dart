library lb_planner.modules.app;

import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:lb_planner/modules/settings/settings.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
        ThemingModule(),
      ];

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r
      ..module(
        '/auth',
        module: AuthModule(),
        customTransition: defaultTransition,
        transition: TransitionType.custom,
      )
      ..child(
        '/',
        child: (_) => const SidebarScreen(),
        children: [
          ModuleRoute(
            '/dashboard',
            module: DashboardModule(),
            customTransition: defaultTransition,
            transition: TransitionType.custom,
          ),
          ModuleRoute(
            '/calendar',
            module: CalendarModule(),
            customTransition: defaultTransition,
            transition: TransitionType.custom,
          ),
          ModuleRoute(
            '/settings',
            module: SettingsModule(),
            customTransition: defaultTransition,
            transition: TransitionType.custom,
          ),
        ],
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [
          AuthGuard(redirectTo: '/auth/'),
        ],
        maintainState: false,
      );
  }
}

/// The default page transition for the application.
///
/// **Usage:**
///
/// ```dart
/// r.module(
///  '/my-module',
///   module: MyModule(),
///   customTransition: defaultTransition,
///   transition: TransitionType.custom,
/// );
///
/// r.child(
///   '/my-child',
///    child: (_) => const MyChild(),
///    customTransition: defaultTransition,
///    transition: TransitionType.custom,
/// );
/// ```
final defaultTransition = CustomTransition(
  transitionBuilder: (context, animation, secondaryAnimation, child) {
    return SharedAxisTransition(
      transitionType: SharedAxisTransitionType.vertical,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  },
);
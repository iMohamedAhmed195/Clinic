import 'package:clinic/feature/signup_features/presentation/view/signup_view.dart';
import 'package:clinic/feature/splash_feature/splash_view_module/splash_view.dart';
import 'package:go_router/go_router.dart';


abstract class AppRouter {

  static const kSignUp = '/signUp';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>   const SplashView(),
      ),
      GoRoute(
        path: kSignUp,
        builder: (context, state) =>   const SignUpView(),
      ),

    ],
  );
}

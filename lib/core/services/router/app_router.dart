import 'package:decor/core/services/local_storage/cache_services.dart';
import 'package:decor/core/services/local_storage/cached_keys.dart';
import 'package:decor/feature/auth/presentation/pages/login_view.dart';
import 'package:decor/feature/auth/presentation/pages/sign_up_view.dart';
import 'package:decor/feature/cart/domain/use_cases/checkout_data.dart';
import 'package:decor/feature/cart/presentation/widgets/check_out.dart';
import 'package:decor/feature/cart/presentation/widgets/finish_order.dart';
import 'package:decor/feature/forget_password/presentation/pages/forget_password_view.dart';
import 'package:decor/feature/forget_password/presentation/pages/set_password_view.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/presentation/pages/home_view.dart';
import 'package:decor/feature/home/presentation/widgets/categories_section/sub_categories_view.dart';
import 'package:decor/feature/home/presentation/widgets/shared/product_details.dart';
import 'package:decor/feature/onboarding/presentation/pages/onboarding_view.dart';
import 'package:decor/feature/profile/presentation/widgets/add_new_card.dart';
import 'package:decor/feature/profile/presentation/widgets/notification_view_body.dart';
import 'package:decor/feature/profile/presentation/widgets/payment_method.dart';
import 'package:decor/feature/search/presentation/pages/search_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const kOnboardingViewBody = '/onboardingViewBody';
  static const kLoginView = '/loginView';
  static const kSignUpView = '/signUpView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kSetPasswordView = '/setPasswordView';
  static const kHomeView = '/homeView';
  static const kSearchView = '/searchView';
  static const kSubCategoriesView = '/subCategoriesView';
  static const kNotificationView = '/notificationView';
  static const kPaymentMethodView = '/paymentMethodView';
  static const kAddNewCardView = '/addNewCardView';
  static const kProductDetails = '/productDetails';
  static const kCheckOut = '/checkOut';
  static const kFinishOrder = '/finishOrder';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final seenOnboarding = CacheServices.getData(CachedKeys.onBoardingKey);
        final loginSuccessFully = CacheServices.getData(CachedKeys.loginKey);
        if (loginSuccessFully == true && state.uri.toString() == '/') {
          return '/homeView';
        } else if (seenOnboarding == true && state.uri.toString() == '/') {
          return '/loginView';
        } else if (seenOnboarding != true && state.uri.toString() == '/') {
          return '/';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingView();
          },
        ),
        GoRoute(
          path: '/loginView',
          builder: (BuildContext context, GoRouterState state) {
            return LoginView();
          },
        ),
        GoRoute(
          path: '/signUpView',
          builder: (BuildContext context, GoRouterState state) {
            return SignUpView();
          },
        ),
        GoRoute(
          path: '/forgetPasswordView',
          builder: (BuildContext context, GoRouterState state) {
            return ForgetPasswordView();
          },
        ),
        GoRoute(
          path: '/setPasswordView',
          builder: (BuildContext context, GoRouterState state) {
            return SetPasswordView();
          },
        ),
        GoRoute(
          path: '/homeView',
          builder: (BuildContext context, GoRouterState state) {
            return HomeView();
          },
        ),
        GoRoute(
          path: '/subCategoriesView',
          builder: (BuildContext context, GoRouterState state) {
            return SubCategoriesView(category: state.extra as CategoryEntity);
          },
        ),
        GoRoute(
          path: '/notificationView',
          builder: (BuildContext context, GoRouterState state) {
            return NotificationViewBody();
          },
        ),
        GoRoute(
          path: '/paymentMethodView',
          builder: (BuildContext context, GoRouterState state) {
            return PaymentMethod();
          },
        ),
        GoRoute(
          path: '/addNewCardView',
          builder: (BuildContext context, GoRouterState state) {
            return AddNewCard();
          },
        ),
        GoRoute(
          path: '/productDetails',
          builder: (BuildContext context, GoRouterState state) {
            return ProductDetails(productItem: state.extra as ProductEntity);
          },
        ),
        GoRoute(
          path: '/checkOut',
          builder: (BuildContext context, GoRouterState state) {
            return CheckoutScreen(data: state.extra as CheckoutData);
          },
        ),
        GoRoute(
          path: '/searchView',
          builder: (BuildContext context, GoRouterState state) {
            final args = state.extra as List;

            return SearchView(
              products: args[0] as List<ProductEntity>,
              categories: args[1] as List<CategoryEntity>,
            );
          },
        ),
        GoRoute(
          path: '/finishOrder',
          builder: (BuildContext context, GoRouterState state) {
            return FinishOrder();
          },
        ),
      ],
    );
  }
}

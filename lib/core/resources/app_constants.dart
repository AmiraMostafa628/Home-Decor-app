import 'package:decor/core/resources/assets_manager.dart';
import 'package:decor/core/services/router/app_router.dart';
import 'package:decor/feature/cart/presentation/pages/cart_view_body.dart';
import 'package:decor/feature/favorite/presentation/pages/fav_view_body.dart';
import 'package:decor/feature/home/domain/entities/notification_setting.dart';
import 'package:decor/feature/home/domain/entities/payment_method_item.dart';
import 'package:decor/feature/home/domain/entities/profile_item.dart';
import 'package:decor/feature/home/presentation/pages/categories_view_body.dart';
import 'package:decor/feature/home/presentation/pages/home_view_body.dart';
import 'package:decor/feature/onboarding/domain/entities/onboarding.dart';
import 'package:decor/feature/profile/presentation/pages/profile_view_body.dart';
import 'package:flutter/material.dart';

class AppConstants {

  static final List<Onboarding> items = [
    Onboarding(
      image: AssetsManager.onboarding1,
      title: "Comfortable Space",
      description:
          "Enjoy a space that offers comfort and relaxation, where smart design meets serene ambiance.",
    ),
    Onboarding(
      image: AssetsManager.onboarding2,
      title: "Modern Design",
      description:
          "A modern design that blends elegance and functionality, creating a perfect environment for your lifestyle.",
    ),
    Onboarding(
      image: AssetsManager.onboarding3,
      title: "Styled Living",
      description:
          "Live in style with details designed for a luxurious and distinctive experience.",
    ),

    Onboarding(
      image: AssetsManager.onboarding4,
      title: "Relaxing Furniture",
      description:
          "Every corner is designed to provide unparalleled comfort, making you feel at home in your own world.",
    ),
  ];

  static final List<Widget> destinationsItems = [
    NavigationDestination(
      icon: ImageIcon(
        AssetImage(AssetsManager.homeIcon),
        // color: ColorManager.blackColor,
      ),
      label: '',
    ),
    NavigationDestination(
      icon: ImageIcon(
        AssetImage(AssetsManager.categoriesIcon),
        // color: ColorManager.blackColor,
      ),
      label: '',
    ),
    NavigationDestination(
      icon: ImageIcon(
        AssetImage(AssetsManager.cartIcon),
        // color: ColorManager.blackColor,
      ),
      label: '',
    ),
    NavigationDestination(
      icon: ImageIcon(
        AssetImage(AssetsManager.wishlistIcon),
        // color: ColorManager.blackColor,
      ),
      label: '',
    ),
    NavigationDestination(
      icon: ImageIcon(
        AssetImage(AssetsManager.profileIcon),
        // color: ColorManager.blackColor,
      ),
      label: '',
    ),
  ];

  static final List<Widget> screens = [
    HomeViewBody(),
    CategoriesViewBody(),
    CartViewBody(),
    FavViewBody(),
    ProfileViewBody(),
  ];

  static final List<ProfileItem> profileItems = [
    ProfileItem(title: 'Privacy Policy', icon: Icons.key, navigationLocation: ''),
    ProfileItem(title: 'Payment Methods', icon: Icons.payment, navigationLocation: AppRouter.kPaymentMethodView),
    ProfileItem(title: 'Notification', icon: Icons.notifications_none, navigationLocation: AppRouter.kNotificationView),
    ProfileItem(title: 'Settings', icon: Icons.settings, navigationLocation: ''),
    ProfileItem(title: 'Help', icon: Icons.help_outline, navigationLocation: ''),
    ProfileItem(title: 'Logout', icon: Icons.logout, navigationLocation: ''),
  ];

  static final List<PaymentMethodItem> paymentMethodItems = [
    PaymentMethodItem(icon: Icons.payment, method: 'Credit Card'),
    PaymentMethodItem(icon: Icons.apple, method: 'Apple Pay'),
    PaymentMethodItem(icon: Icons.paypal, method: 'Pay Pal'),
    PaymentMethodItem(icon: Icons.attach_money, method: 'Cash'),

  ];

 static final List<ProfileItem> details = [
    ProfileItem(title: 'Profile', icon: Icons.person_2_outlined, navigationLocation: ''),
    ProfileItem(title: 'My Orders', icon: Icons.local_offer_outlined, navigationLocation: ''),

  ];

 static final List<NotificationSetting> notifications =[
   NotificationSetting(id: 'general', title: 'General Notification', isEnabled: true),
   NotificationSetting(id: 'sound', title: 'Sound', isEnabled: true),
   NotificationSetting(id: 'call', title: 'Sound Call', isEnabled: true),
   NotificationSetting(id: 'Vibrate', title: 'Vibrate', isEnabled: true),
   NotificationSetting(id: 'Offers', title: 'Special Offers', isEnabled: false),
   NotificationSetting(id: 'Payments', title: 'Payments', isEnabled: false),
   NotificationSetting(id: 'Promo', title: 'Promo and discount', isEnabled: false),
   NotificationSetting(id: 'Cashback', title: 'Cashback', isEnabled: false),
 ];
}

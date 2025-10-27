import 'package:decor/core/services/bloc_observer/bloc_observer.dart';
import 'package:decor/core/services/local_storage/cache_services.dart';
import 'package:decor/core/services/local_storage/hive_cache_helper.dart';
import 'package:decor/core/services/services_locator/services_locator.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';



Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  ServicesLocator.init();
  Bloc.observer = MyBlocObserver();
  await CacheServices.init();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await HiveCacheHelper.initHive();

}

import 'package:decor/feature/auth/data/data_sources/local_data_source/local_data_source.dart';
import 'package:decor/feature/auth/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:decor/feature/auth/data/data_sources/remote_data_source/auth_remote_data_source_impl.dart';
import 'package:decor/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:decor/feature/auth/domain/repositories/auth_repo.dart';
import 'package:decor/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:decor/feature/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:decor/feature/auth/domain/use_cases/log_out_use_case.dart';
import 'package:decor/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:decor/feature/cart/data/data_sources/cart_remote_data_source_impl.dart';
import 'package:decor/feature/cart/data/repositories/cart_repo_impl.dart';
import 'package:decor/feature/cart/domain/repositories/cart_repo.dart';
import 'package:decor/feature/cart/domain/use_cases/toggle_cart_use_case.dart';
import 'package:decor/feature/cart/domain/use_cases/fetch_cart_use_case.dart';
import 'package:decor/feature/favorite/data/data_sources/fav_remote_data_source.dart';
import 'package:decor/feature/favorite/data/data_sources/fav_remote_data_source_impl.dart';
import 'package:decor/feature/favorite/data/repositories/fav_repo_impl.dart';
import 'package:decor/feature/favorite/domain/repositories/fav_repo.dart';
import 'package:decor/feature/favorite/domain/use_cases/toggle_fav_use_case.dart';
import 'package:decor/feature/favorite/domain/use_cases/fetch_fav_use_case.dart';
import 'package:decor/feature/home/data/data_sources/remote_data_source/home_remote_data_source.dart';
import 'package:decor/feature/home/data/data_sources/remote_data_source/home_remote_data_source_impl.dart';
import 'package:decor/feature/home/data/repositories/get_current_user_repo_impl.dart';
import 'package:decor/feature/home/data/repositories/home_repo_impl.dart';
import 'package:decor/feature/home/domain/repositories/get_current_user_repo.dart';
import 'package:decor/feature/home/domain/repositories/home_repo.dart';
import 'package:decor/feature/home/domain/use_cases/category_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/get_current_user_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/product_use_case.dart';
import 'package:decor/feature/home/domain/use_cases/slider_use_case.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator {
  static void init() {
    //local Data source
    sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

    // Auth Remote Data Sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // Auth Repositories
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(authRemoteDataSource: sl(), localDataSource: sl()),
    );

    // Auth UseCases
    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(loginRepository: sl()),
    );
    sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(signUpRepository: sl()),
    );
    sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(logoutRepository: sl()),
    );

    // Home Remote Data Sources
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(),
    );

    // Home Repositories
    sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeRemoteDataSource: sl()),
    );
    sl.registerLazySingleton<GetCurrentUserRepo>(
      () => GetCurrentUserRepoImpl(localDataSource: sl()),
    );

    // Home UseCases
    sl.registerLazySingleton<SliderUseCase>(
      () => SliderUseCase(homeRepo: sl()),
    );
    sl.registerLazySingleton<CategoryUseCase>(
      () => CategoryUseCase(homeRepo: sl()),
    );
    sl.registerLazySingleton<ProductUseCase>(
      () => ProductUseCase(homeRepo: sl()),
    );
    sl.registerLazySingleton<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(currentUserRepo: sl()),
    );

    // cart remote data source
    sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(localDataSource: sl()),
    );

    // cart Repo
    sl.registerLazySingleton<CartRepo>(
      () => CartRepoImpl(cartRemoteDataSource: sl()),
    );

    //cart useCase
    sl.registerLazySingleton<ToggleCartUseCase>(
      () => ToggleCartUseCase(cartRepo: sl()),
    );
    sl.registerLazySingleton<FetchCartUseCase>(
      () => FetchCartUseCase(cartRepo: sl()),
    );

    // fav remote data source
    sl.registerLazySingleton<FavRemoteDataSource>(
      () => FavRemoteDataSourceImpl(localDataSource: sl()),
    );

    // fav Repo
    sl.registerLazySingleton<FavRepo>(
      () => FavRepoImpl(favRemoteDataSource: sl()),
    );

    //fav useCase
    sl.registerLazySingleton<ToggleFavUseCase>(
      () => ToggleFavUseCase(favRepo: sl()),
    );
    sl.registerLazySingleton<FetchFavUseCase>(
      () => FetchFavUseCase(favRepo: sl()),
    );
  }
}

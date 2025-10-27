import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/favorite/domain/repositories/fav_repo.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

class ToggleFavUseCase extends BaseUseCase<bool, ProductEntity> {
  final FavRepo favRepo;

  ToggleFavUseCase({required this.favRepo});

  @override
  FutureFailure<bool> call({required ProductEntity param}) async {
    return await favRepo.toggleFav(product: param);
  }
}

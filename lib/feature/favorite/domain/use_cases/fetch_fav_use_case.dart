import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/favorite/domain/repositories/fav_repo.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';


class FetchFavUseCase extends BaseUseCase<List<ProductEntity>, NoParam> {
  final FavRepo favRepo;

  FetchFavUseCase({required this.favRepo});

  @override
  FutureFailure<List<ProductEntity>> call({required NoParam param}) async {
    return await favRepo.fetchFav();
  }
}

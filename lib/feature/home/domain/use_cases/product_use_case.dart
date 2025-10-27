import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';
import 'package:decor/feature/home/domain/repositories/home_repo.dart';

class ProductUseCase extends BaseUseCase<List<ProductEntity>, NoParam> {
  final HomeRepo homeRepo;

  ProductUseCase({required this.homeRepo});

  @override
  FutureFailure<List<ProductEntity>> call({required NoParam param}) async {
    return await homeRepo.fetchProducts();
  }
}

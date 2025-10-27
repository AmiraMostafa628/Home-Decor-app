import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/cart/domain/repositories/cart_repo.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';


class FetchCartUseCase extends BaseUseCase<List<ProductEntity>, NoParam> {
  final CartRepo cartRepo;

  FetchCartUseCase({required this.cartRepo});

  @override
  FutureFailure<List<ProductEntity>> call({required NoParam param}) async {
    return await cartRepo.fetchCart();
  }
}

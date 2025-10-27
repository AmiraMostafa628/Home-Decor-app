import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/cart/domain/repositories/cart_repo.dart';
import 'package:decor/feature/home/domain/entities/product_entity.dart';

class ToggleCartUseCase extends BaseUseCase<bool, ProductEntity> {
  final CartRepo cartRepo;

  ToggleCartUseCase({required this.cartRepo});

  @override
  FutureFailure<bool> call({required ProductEntity param}) async {
    return await cartRepo.toggleCart(product: param);
  }
}

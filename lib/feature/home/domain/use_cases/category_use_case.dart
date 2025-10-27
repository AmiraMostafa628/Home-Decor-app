import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/home/domain/entities/category_entity.dart';
import 'package:decor/feature/home/domain/repositories/home_repo.dart';

class CategoryUseCase extends BaseUseCase<List<CategoryEntity>, NoParam> {
  final HomeRepo homeRepo;

  CategoryUseCase({required this.homeRepo});

  @override
  FutureFailure<List<CategoryEntity>> call({required NoParam param}) async {
    return await homeRepo.fetchCategories();
  }
}

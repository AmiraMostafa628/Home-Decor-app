import 'package:decor/core/type_def/type_def_either.dart';
import 'package:decor/core/use_case/base_use_case.dart';
import 'package:decor/feature/home/domain/entities/slider_entity.dart';
import 'package:decor/feature/home/domain/repositories/home_repo.dart';

class SliderUseCase extends BaseUseCase<List<SliderEntity>,NoParam>{
  final HomeRepo homeRepo;

  SliderUseCase({required this.homeRepo});
  @override
  FutureFailure<List<SliderEntity>> call({required NoParam param}) async{
    return await homeRepo.fetchSlider();
  }
}
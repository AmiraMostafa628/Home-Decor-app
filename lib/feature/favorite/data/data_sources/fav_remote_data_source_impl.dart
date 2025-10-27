import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/feature/auth/data/data_sources/local_data_source/local_data_source.dart';
import 'package:decor/feature/favorite/data/data_sources/fav_remote_data_source.dart';
import 'package:decor/feature/home/data/models/product_model.dart';

class FavRemoteDataSourceImpl implements FavRemoteDataSource {
  final LocalDataSource localDataSource;

  FavRemoteDataSourceImpl({required this.localDataSource});

  @override
  Future<bool> toggleFav({required ProductModel product}) async {
    try {
      final currentUser = await localDataSource.getUserData();
      if (currentUser?.uId == null) {
        throw ServerFailure(message: 'No User Found');
      }

      final favRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uId)
          .collection('fav');

      final existing = await favRef
          .where('id', isEqualTo: product.id)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        await favRef.doc(existing.docs.first.id).delete();
        return false;
      } else {
        await favRef.add(product.toJson());
        return true;
      }
    } catch (error) {
      throw ServerFailure(
        message: 'AddToFav Error: ${error.runtimeType} - ${error.toString()}',
      );
    }
  }

  @override
  Future<List<ProductModel>> fetchFav() async {
    try {
      late List<ProductModel> products;
      final currentUser = await localDataSource.getUserData();
      if (currentUser?.uId == null) {
        throw ServerFailure(message: 'No User Found');
      }

      final favRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uId)
          .collection('fav');

      final result = await favRef.get();

      products = result.docs
          .map((p) => ProductModel.fromJson(p.data()))
          .toList();

      return products;
    } catch (error) {
      throw ServerFailure(
        message: 'fetch Fav Error: ${error.runtimeType} - ${error.toString()}',
      );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/feature/auth/data/data_sources/local_data_source/local_data_source.dart';
import 'package:decor/feature/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:decor/feature/home/data/models/product_model.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final LocalDataSource localDataSource;

  CartRemoteDataSourceImpl({required this.localDataSource});

  @override
  Future<bool> toggleCart({required ProductModel product}) async {
    try {
      final currentUser = await localDataSource.getUserData();
      if (currentUser?.uId == null) {
        throw ServerFailure(message: 'No User Found');
      }

      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uId)
          .collection('cart');

      final existing = await cartRef
          .where('id', isEqualTo: product.id)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        await cartRef.doc(existing.docs.first.id).delete();
        return false;
      } else {
        await cartRef.add(product.toJson());
        return true;
      }
    } catch (error) {
      throw ServerFailure(
        message: 'AddToCart Error: ${error.runtimeType} - ${error.toString()}',
      );
    }
  }

  @override
  Future<List<ProductModel>> fetchCart() async {
    try {
      late List<ProductModel> products;
      final currentUser = await localDataSource.getUserData();
      if (currentUser?.uId == null) {
        throw ServerFailure(message: 'No User Found');
      }

      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uId)
          .collection('cart');

      final result = await cartRef.get();

      products = result.docs
          .map((p) => ProductModel.fromJson(p.data()))
          .toList();

      return products;
    } catch (error) {
      throw ServerFailure(
        message: 'fetch Cart Error: ${error.runtimeType} - ${error.toString()}',
      );
    }
  }
}

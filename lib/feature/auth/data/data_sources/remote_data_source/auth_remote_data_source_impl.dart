import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/core/connection/failure.dart';
import 'package:decor/core/connection/failure_exception.dart';
import 'package:decor/feature/auth/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:decor/feature/auth/data/models/login_model.dart';
import 'package:decor/feature/auth/data/models/sign_up_model.dart';
import 'package:decor/feature/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {


  @override
  Future<UserModel> login({required LoginModel model}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      final user = credential.user;

      if (user == null) {
        throw ServerFailure(message: 'No user returned from Firebase.');
      }
      if (!credential.user!.emailVerified) {
        await credential.user!.sendEmailVerification();
        throw ServerFailure(
          message:
              'Email not verified. A verification link has been sent to your email.',
        );
      }

      final response = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!response.exists || response.data() == null) {
        throw ServerFailure(message: 'User data not found in FireStore.');
      }

      return UserModel.fromJson(response.data()!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthCodeMapper.handleException(e.code);
    } catch (e) {
      throw ServerFailure(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUp({required SignUpModel model}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.email,
            password: model.password,
          );

      if (credential.user != null && !credential.user!.emailVerified) {
        User? user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification();
      }

      UserModel userModel = UserModel(
        uId: credential.user!.uid,
        email: model.email,
        name: model.name,
        mobileNumber: model.mobileNumber,
        dateOfBirth: model.dateOfBirth,
        photoUrl: model.photoUrl,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uId)
          .set(userModel.toJson());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthCodeMapper.handleException(e.code);
    } catch (e) {
      throw ServerFailure(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

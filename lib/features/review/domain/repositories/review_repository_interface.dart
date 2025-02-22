import 'package:dubucket/features/review/domain/models/review_body_model.dart';
import 'package:dubucket/features/review/domain/models/review_model.dart';
import 'package:dubucket/interfaces/repository_interface.dart';

abstract class ReviewRepositoryInterface extends RepositoryInterface {
  @override
  Future<List<ReviewModel>?> getList({int? offset, String? storeID});
  Future<dynamic> submitReview(ReviewBodyModel reviewBody);
  Future<dynamic> submitDeliveryManReview(ReviewBodyModel reviewBody);
}
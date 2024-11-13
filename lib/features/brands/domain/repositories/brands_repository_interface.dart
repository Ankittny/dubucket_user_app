import 'package:dubucket/features/item/domain/models/item_model.dart';
import 'package:dubucket/interfaces/repository_interface.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
}
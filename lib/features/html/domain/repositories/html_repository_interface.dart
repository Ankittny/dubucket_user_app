import 'package:dubucket/interfaces/repository_interface.dart';
import 'package:dubucket/util/html_type.dart';

abstract class HtmlRepositoryInterface extends RepositoryInterface {
  Future<dynamic> getHtmlText(HtmlType htmlType);
}
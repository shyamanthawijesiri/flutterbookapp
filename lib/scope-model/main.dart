
import 'package:first_app/scope-model/products.dart';
import 'package:first_app/scope-model/user.dart';
import 'package:scoped_model/scoped_model.dart';
import './products.dart';
import './user.dart';

class MainModel extends Model with UserModel, ProductsModel {}
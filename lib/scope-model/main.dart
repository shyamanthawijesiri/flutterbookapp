
import 'package:first_app/scope-model/connected_products.dart';

import 'package:scoped_model/scoped_model.dart';


class MainModel extends Model with UserModel, ProductsModel,ConnectedProductsModel {}
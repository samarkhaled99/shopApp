class HomeModel{
  bool status;
  HomeDataModel data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductModel>products=[];

  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    print('error for add');
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    }
    );
    print('error after add');
    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
    
  }
}
class BannerModel{
  int id;
  String image;
  BannerModel.fromJson(Map<String,dynamic>json){
id= json['id'];
image= json['image'];
print('errorrrrrrrr');
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool isFavorites;
  bool inCart;
  ProductModel.fromJson(Map<String,dynamic>json){
 id = json ['id'];
 price = json ['price'];
 oldPrice = json ['old_price'];
 discount = json ['discount'];
 image = json ['image'];
 name = json ['name'];
 isFavorites = json ['in_favorites'];
 inCart = json ['in_cart'];
  }}
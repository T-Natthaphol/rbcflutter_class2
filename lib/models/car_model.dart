// class Car {
//   final int id;
//   final String brand;
//   final String model;
//   final String car;
//   final String image;
//   final int price;

//   Car({
//     required this.id,
//     required this.brand,
//     required this.model,
//     required this.car,
//     required this.image,
//     required this.price,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return Car(
//       id: json['id'],
//       brand: json['car_brand'],
//       model: json['car_model'],
//       car: json['car'],
//       image: json['car_image'],
//       price: json['price'],
//     );
//   }
// }


class CarModel {
  int? id;
  String? car;
  String? carModel;
  String? carColor;
  int? carModelYear;
  String? carVin;
  String? price;
  bool? availability;

  CarModel(
      {this.id,
      this.car,
      this.carModel,
      this.carColor,
      this.carModelYear,
      this.carVin,
      this.price,
      this.availability});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carModelYear = json['car_model_year'];
    carVin = json['car_vin'];
    price = json['price'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car;
    data['car_model'] = this.carModel;
    data['car_color'] = this.carColor;
    data['car_model_year'] = this.carModelYear;
    data['car_vin'] = this.carVin;
    data['price'] = this.price;
    data['availability'] = this.availability;
    return data;
  }
}

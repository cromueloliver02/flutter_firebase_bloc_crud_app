import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class Product {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int quantity;
  final double price;
  final bool isPopular;
  final bool isRecommended;
  final DateTime dateCreated;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.isPopular,
    required this.isRecommended,
    required this.dateCreated,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? quantity,
    double? price,
    bool? isPopular,
    bool? isRecommended,
    DateTime? dateCreated,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isPopular: isPopular ?? this.isPopular,
      isRecommended: isRecommended ?? this.isRecommended,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'quantity': quantity});
    result.addAll({'price': price});
    result.addAll({'isPopular': isPopular});
    result.addAll({'isRecommended': isRecommended});
    result.addAll({'dateCreated': dateCreated.millisecondsSinceEpoch});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      isPopular: map['isPopular'] ?? false,
      isRecommended: map['isRecommended'] ?? false,
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, imageUrl: $imageUrl, quantity: $quantity, price: $price, isPopular: $isPopular, isRecommended: $isRecommended, dateCreated: $dateCreated)';
  }

  static final List<Product> products = [
    Product(
      id: uuid.v4(),
      name: 'Samsung Headphone',
      description:
          'Headphones are a pair of padded speakers which you wear over your ears in order to listen to a radio or recorded music, or for using a phone without other people hearing it.',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
      quantity: 17,
      price: 1399.0,
      isPopular: true,
      isRecommended: false,
      dateCreated: DateTime.now(),
    ),
    Product(
      id: uuid.v4(),
      name: 'Apple Watch',
      description:
          'A watch is a portable timepiece intended to be carried or worn by a person. It is designed to keep a consistent movement despite the motions caused by the person\'s activities.',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1699&q=80',
      quantity: 96,
      price: 899.0,
      isPopular: true,
      isRecommended: true,
      dateCreated: DateTime.now(),
    ),
    Product(
      id: uuid.v4(),
      name: 'Tesla Sunglass',
      description:
          'Sunglasses are used to shade the eyes from sunlight. They are usually made of a plastic or metal frame and two lenses that are darkened to filter out light. Sunglasses can have prescription lenses like eyeglasses, but they can also have lenses that are not for correcting vision.',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80',
      quantity: 123,
      price: 1199.0,
      isPopular: false,
      isRecommended: true,
      dateCreated: DateTime.now(),
    ),
    Product(
      id: uuid.v4(),
      name: 'Puma Shoe',
      description:
          'A shoe is an item of footwear intended to protect and comfort the human foot. They are often worn with a sock. Shoes are also used as an item of decoration and fashion. The design of shoes has varied enormously through time and from culture to culture, with form originally being tied to function.',
      imageUrl:
          'https://images.unsplash.com/photo-1545289414-1c3cb1c06238?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
      quantity: 78,
      price: 2599.0,
      isPopular: false,
      isRecommended: false,
      dateCreated: DateTime.now(),
    ),
    Product(
      id: uuid.v4(),
      name: 'Apple Laptop',
      description:
          'The MacBook is Apple\'s third laptop computer family, introduced in 2006. Prior laptops were the PowerBook and iBook. In 2015, new MacBooks featured Apple\'s Retina Display and higher resolutions, as well as the Force Touch trackpad that senses different pressure levels.',
      imageUrl:
          'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
      quantity: 1328,
      price: 76899.0,
      isPopular: true,
      isRecommended: true,
      dateCreated: DateTime.now(),
    ),
    Product(
      id: uuid.v4(),
      name: 'Redragon Keyboard',
      description:
          'Sturdy Keyboard Base made off Aircraft-grade Aluminium. Compact space saving design with 87 Full Size keys. All 87 keys are 100% conflict free, anti-ghosting.',
      imageUrl:
          'https://images.unsplash.com/photo-1625948515291-69613efd103f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
      quantity: 263,
      price: 6299.0,
      isPopular: false,
      isRecommended: true,
      dateCreated: DateTime.now(),
    ),
  ];
}

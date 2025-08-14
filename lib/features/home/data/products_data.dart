import 'package:fig/features/home/domain/model/category_model.dart';

final List<ProductModel> allProducts = [
  ProductModel(
    id: '1',
    categoryId: '1',
    title: 'Slim Blazer',
    imageUrls: [
      'assets/images/1.jpg',
      'assets/images/2.jpg',
      'assets/images/3.jpg',

      'assets/images/10.jpg',
      'assets/images/11.jpg',
      'assets/images/12.jpg',
    ],
    description:
        'Elegant navy blue slim blazer. Perfect for office or casual outings. Comfortable fit and stylish design.',
    price: 1200.0,
    availableColors: ['Black', 'Red', 'Navy', 'Green', 'Beige'],
    availableSizes: [44, 36, 42, 46],
  ),
  ProductModel(
    id: '2',
    categoryId: '1',
    title: 'Classic Black Blazer',
    imageUrls: [
      'assets/images/4.jpg',
      'assets/images/5.jpg',
      'assets/images/6.jpg',
    ],
    description:
        'Timeless black blazer. Stylish and comfortable. Perfect for evening or formal occasions.',
    price: 1300.0,
    availableColors: ['Green', 'Navy', 'White', 'Black'],
    availableSizes: [44, 46, 40, 48],
  ),
  ProductModel(
    id: '3',
    categoryId: '1',
    title: 'Grey Blazer',
    imageUrls: [
      'assets/images/7.jpg',
      'assets/images/8.jpg',
      'assets/images/9.jpg',

      'assets/images/10.jpg',
      'assets/images/11.jpg',
      'assets/images/12.jpg',
    ],
    description:
        'Modern grey blazer. Lightweight fabric. Can be paired with jeans or formal pants.',
    price: 1100.0,
    availableColors: ['Green', 'Grey', 'Navy', 'Black', 'Red'],
    availableSizes: [46, 36, 48, 44, 40],
  ),
  ProductModel(
    id: '4',
    categoryId: '1',
    title: 'Checked Blazer',
    imageUrls: [
      'assets/images/10.jpg',
      'assets/images/11.jpg',
      'assets/images/12.jpg',
    ],
    description:
        'Stylish checked pattern blazer. Ideal for office wear. Elegant and fashionable.',
    price: 1250.0,
    availableColors: ['Red', 'Grey', 'White', 'Beige'],
    availableSizes: [36, 38, 44, 46],
  ),
  ProductModel(
    id: '5',
    categoryId: '1',
    title: 'Double-breasted Blazer',
    imageUrls: [
      'assets/images/13.jpg',
      'assets/images/14.jpg',
      'assets/images/15.jpg',
    ],
    description:
        'Elegant double-breasted design. Comfortable and chic. Perfect for formal events.',
    price: 1400.0,
    availableColors: ['Black', 'Beige', 'Navy'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '6',
    categoryId: '1',
    title: 'Linen Blazer',
    imageUrls: [
      'assets/images/16.jpg',
      'assets/images/17.jpg',
      'assets/images/18.jpg',
    ],
    description:
        'Lightweight linen fabric. Breathable and stylish. Great for summer outings.',
    price: 1150.0,
    availableColors: ['Grey', 'Green', 'Red'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '7',
    categoryId: '2',
    title: 'Silk Blouse',
    imageUrls: [
      'assets/images/19.jpg',
      'assets/images/20.jpg',
      'assets/images/21.jpg',
    ],
    description:
        'Soft pink silk blouse. Comfortable and elegant. Perfect for casual and formal wear.',
    price: 700.0,
    availableColors: ['White', 'Red', 'Beige'],
    availableSizes: [36, 40, 42, 44],
  ),
  ProductModel(
    id: '8',
    categoryId: '2',
    title: 'Floral Blouse',
    imageUrls: [
      'assets/images/22.jpg',
      'assets/images/23.jpg',
      'assets/images/24.jpg',
    ],
    description:
        'Bright floral print blouse. Lightweight fabric. Ideal for spring and summer.',
    price: 650.0,
    availableColors: ['Green', 'Red', 'Navy', 'Beige'],
    availableSizes: [38, 40, 42],
  ),
  ProductModel(
    id: '9',
    categoryId: '2',
    title: 'Sleeveless Blouse',
    imageUrls: [
      'assets/images/25.jpg',
      'assets/images/26.jpg',
      'assets/images/27.jpg',
    ],
    description:
        'Light summer style sleeveless blouse. Elegant and airy. Perfect for hot weather.',
    price: 550.0,
    availableColors: ['White', 'Black', 'Grey'],
    availableSizes: [36, 38, 42, 44, 46],
  ),
  ProductModel(
    id: '10',
    categoryId: '2',
    title: 'Ruffled Blouse',
    imageUrls: [
      'assets/images/28.jpg',
      'assets/images/29.jpg',
      'assets/images/30.jpg',
    ],
    description:
        'Elegant ruffles design. Soft and comfortable. Can be dressed up or down.',
    price: 750.0,
    availableColors: ['Navy', 'Red', 'Green', 'Black'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '11',
    categoryId: '2',
    title: 'Buttoned Blouse',
    imageUrls: [
      'assets/images/31.jpg',
      'assets/images/1.jpg',
      'assets/images/2.jpg',
    ],
    description:
        'Casual buttoned blouse. Light and stylish. Great for everyday wear.',
    price: 600.0,
    availableColors: ['White', 'Beige', 'Grey'],
    availableSizes: [36, 38, 40],
  ),
  ProductModel(
    id: '12',
    categoryId: '2',
    title: 'Chiffon Blouse',
    imageUrls: [
      'assets/images/3.jpg',
      'assets/images/4.jpg',
      'assets/images/5.jpg',
    ],
    description: 'Light chiffon fabric. Elegant drape. Perfect for layering.',
    price: 680.0,
    availableColors: ['Red', 'Navy', 'Green', 'White'],
    availableSizes: [38, 40, 42, 44, 46],
  ),
  ProductModel(
    id: '13',
    categoryId: '3',
    title: 'Black Bodysuit',
    imageUrls: [
      'assets/images/6.jpg',
      'assets/images/7.jpg',
      'assets/images/8.jpg',
    ],
    description:
        'Comfortable black bodysuit. Slim fit design. Perfect for pairing with skirts or pants.',
    price: 550.0,
    availableColors: ['Black', 'Red', 'Beige'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '14',
    categoryId: '3',
    title: 'White Bodysuit',
    imageUrls: [
      'assets/images/9.jpg',
      'assets/images/10.jpg',
      'assets/images/11.jpg',
    ],
    description:
        'Elegant white bodysuit. Stretchable fabric. Suitable for casual or formal occasions.',
    price: 580.0,
    availableColors: ['White', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 44],
  ),
  ProductModel(
    id: '15',
    categoryId: '3',
    title: 'Lace Bodysuit',
    imageUrls: [
      'assets/images/12.jpg',
      'assets/images/13.jpg',
      'assets/images/14.jpg',
    ],
    description:
        'Delicate lace design. Comfortable and chic. Perfect for evening wear.',
    price: 620.0,
    availableColors: ['Red', 'White', 'Beige'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '16',
    categoryId: '3',
    title: 'Long Sleeve Bodysuit',
    imageUrls: [
      'assets/images/15.jpg',
      'assets/images/16.jpg',
      'assets/images/17.jpg',
    ],
    description:
        'Perfect for layering. Comfortable fabric. Elegant design for everyday wear.',
    price: 600.0,
    availableColors: ['Black', 'Grey', 'White'],
    availableSizes: [36, 38, 42, 44, 46],
  ),
  ProductModel(
    id: '17',
    categoryId: '3',
    title: 'Tank Bodysuit',
    imageUrls: [
      'assets/images/18.jpg',
      'assets/images/19.jpg',
      'assets/images/20.jpg',
    ],
    description: 'Casual tank style. Slim fit. Ideal for summer.',
    price: 530.0,
    availableColors: ['White', 'Navy', 'Beige'],
    availableSizes: [36, 38, 40],
  ),
  ProductModel(
    id: '18',
    categoryId: '3',
    title: 'Striped Bodysuit',
    imageUrls: [
      'assets/images/21.jpg',
      'assets/images/22.jpg',
      'assets/images/23.jpg',
    ],
    description:
        'Modern striped look. Comfortable and stylish. Can be worn casually or formally.',
    price: 590.0,
    availableColors: ['Red', 'Grey', 'Black', 'White'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '19',
    categoryId: '4',
    title: 'Cozy Cardigan',
    imageUrls: [
      'assets/images/24.jpg',
      'assets/images/25.jpg',
      'assets/images/26.jpg',
    ],
    description:
        'Warm beige cardigan. Soft knitted fabric. Perfect for layering during chilly days.',
    price: 650.0,
    availableColors: ['Beige', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '20',
    categoryId: '4',
    title: 'Knitted Cardigan',
    imageUrls: [
      'assets/images/27.jpg',
      'assets/images/28.jpg',
      'assets/images/29.jpg',
    ],
    description:
        'Soft knitted fabric cardigan. Elegant and comfortable. Ideal for casual or semi-formal wear.',
    price: 700.0,
    availableColors: ['Black', 'Beige', 'Red', 'White'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '21',
    categoryId: '4',
    title: 'Button Cardigan',
    imageUrls: [
      'assets/images/30.jpg',
      'assets/images/31.jpg',
      'assets/images/1.jpg',
    ],
    description:
        'Classic button style cardigan. Light and warm. Stylish for daily wear.',
    price: 680.0,
    availableColors: ['Grey', 'Black', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '22',
    categoryId: '4',
    title: 'Long Cardigan',
    imageUrls: [
      'assets/images/2.jpg',
      'assets/images/3.jpg',
      'assets/images/4.jpg',
    ],
    description:
        'Elegant long cardigan design. Comfortable and versatile. Great for layering over dresses or jeans.',
    price: 720.0,
    availableColors: ['Beige', 'Navy', 'White', 'Grey'],
    availableSizes: [38, 40, 42, 44, 46],
  ),
  ProductModel(
    id: '23',
    categoryId: '4',
    title: 'Chunky Cardigan',
    imageUrls: [
      'assets/images/5.jpg',
      'assets/images/6.jpg',
      'assets/images/7.jpg',
    ],
    description:
        'Thick and warm chunky cardigan. Soft and cozy fabric. Ideal for cold weather.',
    price: 750.0,
    availableColors: ['Black', 'Beige', 'Grey'],
    availableSizes: [40, 42, 44, 46],
  ),
  ProductModel(
    id: '24',
    categoryId: '4',
    title: 'Open Front Cardigan',
    imageUrls: [
      'assets/images/8.jpg',
      'assets/images/9.jpg',
      'assets/images/10.jpg',
    ],
    description:
        'Casual open front cardigan. Light and comfortable. Perfect for layering over tops or dresses.',
    price: 670.0,
    availableColors: ['White', 'Grey', 'Navy', 'Beige'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '25',
    categoryId: '5',
    title: 'Green Cargo Pants',
    imageUrls: [
      'assets/images/11.jpg',
      'assets/images/12.jpg',
      'assets/images/13.jpg',
    ],
    description:
        'Durable green cargo pants. Comfortable fit. Great for casual and outdoor wear.',
    price: 800.0,
    availableColors: ['Green', 'Beige', 'Black'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '26',
    categoryId: '5',
    title: 'Beige Cargo Pants',
    imageUrls: [
      'assets/images/14.jpg',
      'assets/images/15.jpg',
      'assets/images/16.jpg',
    ],
    description:
        'Casual beige cargo pants. Lightweight and durable. Perfect for everyday use.',
    price: 780.0,
    availableColors: ['Beige', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '27',
    categoryId: '5',
    title: 'Slim Cargo Pants',
    imageUrls: [
      'assets/images/17.jpg',
      'assets/images/18.jpg',
      'assets/images/19.jpg',
    ],
    description:
        'Modern slim fit cargo pants. Comfortable and stylish. Ideal for casual outings.',
    price: 820.0,
    availableColors: ['Black', 'Green', 'Beige'],
    availableSizes: [38, 40, 42, 44],
  ),
  ProductModel(
    id: '28',
    categoryId: '5',
    title: 'Camouflage Cargo Pants',
    imageUrls: [
      'assets/images/20.jpg',
      'assets/images/21.jpg',
      'assets/images/22.jpg',
    ],
    description:
        'Stylish camo print cargo pants. Durable and versatile. Perfect for outdoor activities.',
    price: 850.0,
    availableColors: ['Green', 'Grey', 'Beige'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '29',
    categoryId: '5',
    title: 'Black Cargo Pants',
    imageUrls: [
      'assets/images/23.jpg',
      'assets/images/24.jpg',
      'assets/images/25.jpg',
    ],
    description:
        'Classic black cargo pants. Comfortable and durable. Suitable for casual or semi-formal wear.',
    price: 790.0,
    availableColors: ['Black', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '30',
    categoryId: '5',
    title: 'Wide-leg Cargo Pants',
    imageUrls: [
      'assets/images/26.jpg',
      'assets/images/27.jpg',
      'assets/images/28.jpg',
    ],
    description:
        'Comfortable wide-leg cargo pants. Stylish and breathable. Ideal for summer outings.',
    price: 810.0,
    availableColors: ['Beige', 'Green', 'White'],
    availableSizes: [38, 40, 42, 44, 46],
  ),
  ProductModel(
    id: '31',
    categoryId: '6',
    title: 'Formal White Shirt',
    imageUrls: [
      'assets/images/29.jpg',
      'assets/images/30.jpg',
      'assets/images/31.jpg',
    ],
    description:
        'Classic white formal shirt. Elegant design with comfortable fit. Perfect for office or formal events.',
    price: 450.0,
    availableColors: ['White', 'Beige', 'Grey'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '32',
    categoryId: '6',
    title: 'Casual Shirt',
    imageUrls: [
      'assets/images/1.jpg',
      'assets/images/2.jpg',
      'assets/images/3.jpg',
    ],
    description:
        'Comfortable casual shirt. Lightweight fabric, perfect for everyday wear. Stylish and versatile.',
    price: 430.0,
    availableColors: ['Blue', 'White', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '33',
    categoryId: '6',
    title: 'Checked Shirt',
    imageUrls: [
      'assets/images/4.jpg',
      'assets/images/5.jpg',
      'assets/images/6.jpg',
    ],
    description:
        'Stylish checked pattern shirt. Comfortable and breathable. Can be paired with jeans or skirts.',
    price: 480.0,
    availableColors: ['Red', 'Grey', 'Blue'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '34',
    categoryId: '6',
    title: 'Denim Shirt',
    imageUrls: [
      'assets/images/7.jpg',
      'assets/images/8.jpg',
      'assets/images/9.jpg',
    ],
    description:
        'Rugged denim look. Soft and comfortable fabric. Suitable for casual outings.',
    price: 500.0,
    availableColors: ['Blue', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '35',
    categoryId: '6',
    title: 'Linen Shirt',
    imageUrls: [
      'assets/images/10.jpg',
      'assets/images/11.jpg',
      'assets/images/12.jpg',
    ],
    description:
        'Light linen fabric. Breathable and comfortable. Perfect for summer and spring.',
    price: 460.0,
    availableColors: ['Beige', 'White', 'Grey'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '36',
    categoryId: '6',
    title: 'Striped Shirt',
    imageUrls: [
      'assets/images/13.jpg',
      'assets/images/14.jpg',
      'assets/images/15.jpg',
    ],
    description:
        'Modern striped look shirt. Comfortable and stylish. Suitable for casual or semi-formal wear.',
    price: 470.0,
    availableColors: ['Blue', 'White', 'Red'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '37',
    categoryId: '7',
    title: 'Leather Jacket',
    imageUrls: [
      'assets/images/16.jpg',
      'assets/images/17.jpg',
      'assets/images/18.jpg',
    ],
    description:
        'Classic leather jacket. Stylish and durable. Perfect for casual or semi-formal outings.',
    price: 1500.0,
    availableColors: ['Black', 'Brown', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '38',
    categoryId: '7',
    title: 'Bomber Jacket',
    imageUrls: [
      'assets/images/19.jpg',
      'assets/images/20.jpg',
      'assets/images/21.jpg',
    ],
    description:
        'Stylish bomber jacket. Comfortable fit with trendy design. Ideal for everyday wear.',
    price: 1400.0,
    availableColors: ['Black', 'Green', 'Beige'],
    availableSizes: [36, 38, 40, 42],
  ),
  ProductModel(
    id: '39',
    categoryId: '7',
    title: 'Denim Jacket',
    imageUrls: [
      'assets/images/22.jpg',
      'assets/images/23.jpg',
      'assets/images/24.jpg',
    ],
    description:
        'Casual denim jacket. Soft and durable fabric. Perfect for layering over tops or dresses.',
    price: 1350.0,
    availableColors: ['Blue', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '40',
    categoryId: '7',
    title: 'Hooded Jacket',
    imageUrls: [
      'assets/images/25.jpg',
      'assets/images/26.jpg',
      'assets/images/27.jpg',
    ],
    description:
        'Casual hooded jacket. Comfortable and versatile. Great for outdoor activities.',
    price: 1300.0,
    availableColors: ['Black', 'Grey', 'Navy'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
  ProductModel(
    id: '41',
    categoryId: '7',
    title: 'Puffer Jacket',
    imageUrls: [
      'assets/images/28.jpg',
      'assets/images/29.jpg',
      'assets/images/30.jpg',
    ],
    description:
        'Warm and padded puffer jacket. Perfect for cold weather. Stylish and cozy.',
    price: 1450.0,
    availableColors: ['Black', 'Red', 'Beige'],
    availableSizes: [38, 40, 42, 44, 46],
  ),
  ProductModel(
    id: '42',
    categoryId: '7',
    title: 'Windbreaker Jacket',
    imageUrls: [
      'assets/images/31.jpg',
      'assets/images/1.jpg',
      'assets/images/2.jpg',
    ],
    description:
        'Lightweight windbreaker jacket. Breathable and stylish. Ideal for spring and autumn outings.',
    price: 1250.0,
    availableColors: ['Green', 'Blue', 'Grey'],
    availableSizes: [36, 38, 40, 42, 44],
  ),
];

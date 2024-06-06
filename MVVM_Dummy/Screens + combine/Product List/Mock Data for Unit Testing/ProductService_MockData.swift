//
//  ProductService_MockData.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 23/05/24.
//

import Foundation
import Combine

class ProductService_MockData: NetworkManager {
    
    func requestItems<T>(modelType: T.Type, type: any EndPoints) -> Future<T, DataError> {
        return Future { promise in
            
            let mockData: [Product] = [
                Product(
                    id: 1,
                    image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                    title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                    category: "men's clothing",
                    price: 109.95,
                    rating: Rate(rate: 3.9, count: 120),
                    description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 2,
                    image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                    title: "Mens Casual Premium Slim Fit T-Shirts",
                    category: "men's clothing",
                    price: 22.3,
                    rating: Rate(rate: 4.1, count: 259),
                    description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 3,
                    image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                    title: "Mens Cotton Jacket",
                    category: "men's clothing",
                    price: 55.99,
                    rating: Rate(rate: 4.7, count: 500),
                    description: "Great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 4,
                    image: "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
                    title: "Mens Casual Slim Fit",
                    category: "men's clothing",
                    price: 15.99,
                    rating: Rate(rate: 2.1, count: 430),
                    description: "The color could be slightly different between on the screen and in practice. / Please note that body builds vary by person, therefore, detailed size information should be reviewed below on the product description.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 5,
                    image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
                    title: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
                    category: "jewelery",
                    price: 695,
                    rating: Rate(rate: 4.6, count: 400),
                    description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 6,
                    image: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
                    title: "Solid Gold Petite Micropave",
                    category: "jewelery",
                    price: 168,
                    rating: Rate(rate: 3.9, count: 70),
                    description: "Satisfaction Guaranteed. Return or exchange any order within 30 days. Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 7,
                    image: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
                    title: "White Gold Plated Princess",
                    category: "jewelery",
                    price: 9.99,
                    rating: Rate(rate: 3, count: 400),
                    description: "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 8,
                    image: "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
                    title: "Pierced Owl Rose Gold Plated Stainless Steel Double",
                    category: "jewelery",
                    price: 10.99,
                    rating: Rate(rate: 1.9, count: 100),
                    description: "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 9,
                    image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
                    title: "WD 2TB Elements Portable External Hard Drive - USB 3.0",
                    category: "electronics",
                    price: 64,
                    rating: Rate(rate: 3.3, count: 203),
                    description: "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 10,
                    image: "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
                    title: "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
                    category: "electronics",
                    price: 109,
                    rating: Rate(rate: 2.9, count: 470),
                    description: "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                    id: 11,
                    image: "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
                    title: "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
                    category: "electronics",
                    price: 109,
                    rating: Rate(rate: 4.8, count: 319),
                    description: "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
                    favourite: false,
                    isDeleted_: false
                ),
                Product(
                        id: 12,
                        image: "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg",
                        title: "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                        category: "electronics",
                        price: 114,
                        rating: Rate(rate: 4.8, count: 400),
                        description: "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 13,
                        image: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
                        title: "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
                        category: "electronics",
                        price: 599,
                        rating: Rate(rate: 2.9, count: 250),
                        description: "21.5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16.7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 14,
                        image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
                        title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED",
                        category: "electronics",
                        price: 999.99,
                        rating: Rate(rate: 2.2, count: 140),
                        description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 15,
                        image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
                        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
                        category: "women's clothing",
                        price: 56.99,
                        rating: Rate(rate: 2.6, count: 235),
                        description: "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm. Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside. Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 16,
                        image: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
                        title: "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
                        category: "women's clothing",
                        price: 29.95,
                        rating: Rate(rate: 2.9, count: 340),
                        description: "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 17,
                        image: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
                        title: "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
                        category: "women's clothing",
                        price: 39.99,
                        rating: Rate(rate: 3.8, count: 679),
                        description: "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it. Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 18,
                        image: "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg",
                        title: "MBJ Women's Solid Short Sleeve Boat Neck V",
                        category: "women's clothing",
                        price: 9.85,
                        rating: Rate(rate: 4.7, count: 130),
                        description: "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 19,
                        image: "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
                        title: "Opna Women's Short Sleeve Moisture",
                        category: "women's clothing",
                        price: 7.95,
                        rating: Rate(rate: 4.5, count: 146),
                        description: "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort.",
                        favourite: false,
                        isDeleted_: false
                    ),
                    Product(
                        id: 20,
                        image: "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
                        title: "DANVOUY Womens T Shirt Casual Cotton Short",
                        category: "women's clothing",
                        price: 12.99,
                        rating: Rate(rate: 3.6, count: 145),
                        description: "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
                        favourite: false,
                        isDeleted_: false
                    )
                ]

            promise(.success(mockData as! T))
            
        }
    }
}

//
//  Product.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 29.06.24.
//

import Foundation

class Product {
    private let title: String
    private let price: String
    private let photoPath: String?
    private let categories: [String]
    var favorite: Bool
    
    init(title: String, price: String, photoPath: String?, categories: [String]) {
        self.title = title
        self.price = price
        self.photoPath = photoPath
        self.categories = categories
        self.favorite = false
    }
    
    func getTitle() -> String{
        return title
    }
    
    func getPrice() -> String{
        return price
    }
    
    func getPhotopath() -> String{
        return photoPath ?? ""
    }
    
    func getCategory() -> [String]{
        return categories
    }
    
    func changeFavorite() {
        favorite.toggle()
    }
    func isFavorite()->Bool{
        return favorite
    }
}



let productsData: [Product] = [
    Product(title: "SUEDE OVERSHIRT WITH CHEST POCKET", price: "199.00€", photoPath: "SUEDE OVERSHIRT WITH CHEST POCKET",
            categories: ["Jackets"]),
    Product(title: "Gabardine Harrington Jacket", price: "1,690.00€", photoPath: "Gabardine Harrington Jacket",
            categories: ["Jackets"]),
    Product(title: "Long Kensington Heritage Trench Coat", price: "2,150.00€", photoPath: "Long Kensington Heritage Trench Coat",
            categories: ["Coats"]),
    Product(title: "double-breasted pinstriped suit", price: "1,700.00€", photoPath: "double-breasted pinstriped suit",
            categories: ["Suits"]),
    Product(title: "Hand-Tailored Wool Gabardine Trouser", price: "795.00€", photoPath: "Hand-Tailored Wool Gabardine Trouser",
            categories: ["Trousers"]),
    Product(title: "Kent Hand-Tailored Striped Suit Jacket", price: "2,495.00€", photoPath: "Kent Hand-Tailored Striped Suit Jacket",
            categories: ["Suits"]),
    Product(title: "Alston Leather Penny Loafer", price: "780.00€", photoPath: "Alston Leather Penny Loafer",
            categories: ["Shoes"]),
    Product(title: "CORDOVAN LEATHER Moros", price: "980.00€", photoPath: "CORDOVAN LEATHER Moros",
            categories: ["Shoes"]),
    Product(title: "Gregory Hand-Tailored Striped Trouser", price: "595.00€", photoPath: "Gregory Hand-Tailored Striped Trouser",
            categories: ["Trousers"]),
    Product(title: "End-on-End Poplin-Collar Shirt", price: "495.00€", photoPath: "End-on-End Poplin-Collar Shirt",
            categories: ["Shirts"]),
    Product(title: "Dalvin Calfskin Oxford", price: "1,250.00€", photoPath: "Dalvin Calfskin Oxford",
            categories: ["Shoes"])
    
]



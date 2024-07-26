//
//  Category.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 29.06.24.
//

import UIKit

class Category {
    private let title: String
    private var select: Bool
//    private var size =  CGSize(width: 0, height: 0)
    init(title: String) {
        self.title = title
        self.select = false
//        self.size = CGSize(width: 10, height: 10)
    }
    
    func changeSelect(){
        select.toggle()
    }
    func isSelected()->Bool{
        return select
    }
    func getTitle()->String{
        return title
    }
//    func setSize(size: CGSize){
//        self.size = size
//    }
//    func getSize() -> CGSize {
//        return size
//    }
    

}


let categoryData: [Category] = [
    Category(title: "All"),
    Category(title: "Jackets"),
    Category(title: "Coats"),
    Category(title: "Shirts"),
    Category(title: "Trousers"),
    Category(title: "T-Shirts"),
    Category(title: "Shoes"),
    Category(title: "Polo Shirts"),
    Category(title: "Suits"),
    Category(title: "Favorites")
]

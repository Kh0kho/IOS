//
//  CategoryCell.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 29.06.24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    private var select = false
    private var category: Category?
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCategoryCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("CategoryCell Error")
    }
    
    func setupCategory(category: Category) {
        self.category = category
        categoryTitle.text = category.getTitle()
        updateCategoryCell()
    }
    
    private func setupCategoryCell() {
        self.addSubview(categoryTitle)
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoryTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoryTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            categoryTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.frame.height/2
    }
    
    
    private func updateCategoryCell() {
        guard let category = category else { return }
        if category.isSelected() {
            categoryTitle.textColor = .white
            self.backgroundColor = .black
        } else {
            categoryTitle.textColor = .black
            self.backgroundColor = .white
        }
    }
    
}

//
//  CategoryCell.swift
//  Slack Page
//
//  Created by Nino Nozadze on 21.06.24.
//

import UIKit

class CategoryCell2: UICollectionViewCell {
    
    private let categoryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let categoryDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupCategoryCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("CategoryCell Error")
    }
    
    private func setupCategoryCell() {
        self.addSubview(categoryStack)
        setupCategoryStackConstraints()
        setupCategoryStack()
        
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    
    private func setupCategoryStackConstraints() {
        NSLayoutConstraint.activate([
            categoryStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            categoryStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            categoryStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            categoryStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupCategoryStack() {
        categoryStack.addArrangedSubview(iconImageView)
        categoryStack.addArrangedSubview(categoryTitle)
        categoryStack.addArrangedSubview(categoryDescription)
    }
    
    func setupCategory(imageName: String, title: String,
                       description: String) {
        iconImageView.image = UIImage(systemName: imageName)
        categoryTitle.text = title
        categoryDescription.text = description
    }
    
}

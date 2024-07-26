//
//  ProductCell.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 30.06.24.
//

import UIKit

class ProductCell: UICollectionViewCell {
    private var product: Product?
    private let imageView = UIImageView()
    private let priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let discriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    private let discriptionTopStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    private let priceLab: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("ProductCell Error")
    }
    
    func setupProduct(product: Product) {
        self.product = product
        imageView.image = UIImage(named: product.getPhotopath())
        priceLab.text = product.getPrice()
        titleLabel.text = product.getTitle()
        changeButtonColor()
        
    }
    
    private func setupCell() {
        addImage()
        addSubview(discriptionStack)
        discriptionTopStack.addArrangedSubview(priceLab)
        discriptionTopStack.addArrangedSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        discriptionStack.addArrangedSubview(discriptionTopStack)
        discriptionStack.addArrangedSubview(titleLabel)
        discriptionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discriptionStack.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            discriptionStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            discriptionStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            discriptionStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    private func addImage(){
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 4.0/3.0)
        ])
    }
    
    @objc private func buttonTapped() {
        product?.changeFavorite()
        changeButtonColor()
        if let product = product {
            NotificationCenter.default.post(name: .favoriteStatusChanged, object: product)
        }
    }
    
    func changeButtonColor(){
        if product!.isFavorite(){
            favoriteButton.tintColor = .red
        }
        else{
            favoriteButton.tintColor = .lightGray
        }
    }
}
extension Notification.Name {
    static let favoriteStatusChanged = Notification.Name("favoriteStatusChanged")
}

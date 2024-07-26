//
//  ProductViewController.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 01.07.24.
//

import UIKit

class ProductViewController: UIViewController {
    private var delegate: ShopViewController
    private var product: Product
    private let photo = UIImageView()
    private let bottomView: UIView  = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        return stack
    }()
    private let discriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let priceLab: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    @objc private func buttonTapped() {
        product.changeFavorite()
        changeButtonColor()
    }
    private let addToCartButton: UIButton = {
            let button = UIButton()
            button.setTitle("Add to Cart", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.masksToBounds = true
            return button
        }()
    
    init(prduct: Product,delegate: ShopViewController) {
        self.product = prduct
        self.delegate  = delegate

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        setupNavigationBar()
        setupPhoto()
        setupBottomView()
    }
    
    private func setupNavigationBar(){
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.backgroundColor = .clear
    }
    @objc
    private func goBack() {
        navigationController?.popViewController(animated: true)
        tabBarController?.tabBar.isHidden = false
        delegate.filterProducts()
    }
    
    private func setupPhoto(){
        view.addSubview(photo)
        photo.image = UIImage(named: product.getPhotopath())
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: view.topAnchor),
            photo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photo.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/4)
        ])
    }
    
    private func setupBottomView(){
        view.addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: -10),
            bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupMainStack()
        bottomView.addSubview(addToCartButton)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
            addToCartButton.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            addToCartButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/5)
        ])
    }
    
    private func setupMainStack(){
        bottomView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20)
        ])
        setupDiscriptionStack()
        titleLabel.text = product.getTitle()
        mainStack.addArrangedSubview(titleLabel)
    }
    
    private func setupDiscriptionStack(){
        mainStack.addArrangedSubview(discriptionStack)
        priceLab.text = product.getPrice()
        discriptionStack.addArrangedSubview(priceLab)
        discriptionStack.addArrangedSubview(favoriteButton)
        changeButtonColor()
    }
    
    func changeButtonColor(){
        if product.isFavorite(){
            favoriteButton.tintColor = .red
        }
        else{
            favoriteButton.tintColor = .lightGray
        }
    }
    
    override func viewDidLayoutSubviews() {
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height/2
    }

}

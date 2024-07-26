//
//  ViewController.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 25.06.24.
//

import UIKit

class ViewController: UIViewController {
    var selectedCategories: Set<String> = []
    var filteredProductsData: [Product] = productsData

    
    var categories: UICollectionView!
    var products: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        setupCategories()
        setupProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(favoriteStatusChanged(_:)), name: .favoriteStatusChanged, object: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "New Colleciton"
    }
    
    private func setupCategories() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        categories = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        view.addSubview(categories)
        setupCategoriesConstraints()
        
        categories.delegate = self
        categories.dataSource = self
        
        categories.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        categories.showsHorizontalScrollIndicator = false
        categories.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    private func setupCategoriesConstraints() {
        categories.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categories.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categories.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categories.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categories.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupProducts() {
        let verticalLayout = UICollectionViewFlowLayout()
        verticalLayout.scrollDirection = .vertical
        verticalLayout.itemSize = CGSize(width: (view.frame.width - 40) / 2 - 10, height: 200)
        
        products = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout)
        products.delegate = self
        products.dataSource = self
        products.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        products.backgroundColor = .white
        products.showsVerticalScrollIndicator = false

        
        view.addSubview(products)
        
        products.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            products.topAnchor.constraint(equalTo: categories.bottomAnchor, constant: 20),
            products.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            products.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            products.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    @objc private func favoriteStatusChanged(_ notification: Notification) {
        if notification.object is Product {
            if selectedCategories.contains("Favorites") {
                filterProducts()
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categories {
            return categoryData.count
        } else {
            return filteredProductsData.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.setupCategory(category: categoryData[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
            cell.setupProduct(product: filteredProductsData[indexPath.row])
            return cell
        }
    }

}

extension ViewController: UICollisionBehaviorDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categories {
            collectionView.deselectItem(at: indexPath, animated: true)
            let category = categoryData[indexPath.row]
            category.changeSelect()
            if category.isSelected() {
                selectedCategories.insert(category.getTitle())
            } else {
                selectedCategories.remove(category.getTitle())
            }
            filterProducts()
            categories.reloadData()
        }
    }
    
    private func filterProducts() {
        if selectedCategories.isEmpty || selectedCategories.contains("All") {
            filteredProductsData = productsData
        } else {
            filteredProductsData = productsData.filter { product in
                return !selectedCategories.isDisjoint(with: product.getCategory()) || (selectedCategories.contains("Favorites") && product.isFavorite())
            }
        }
        products.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categories {
            return calculateCategorySize(indexPath: indexPath)
        } else {
            return CGSize(width: collectionView.frame.size.width/2-10, height: 300)
        }
    }
    
    private func calculateCategorySize(indexPath: IndexPath)->CGSize{
        let label = UILabel()
        label.text = categoryData[indexPath.row].getTitle()
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        let width = label.frame.width + 30
        let height = label.frame.height + 15
        return CGSize(width: width, height: height)
    }
}

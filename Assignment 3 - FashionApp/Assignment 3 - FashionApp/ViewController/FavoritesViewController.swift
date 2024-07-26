//
//  FavoritesViewController.swift
//  Assignment 3 - FashionApp
//
//  Created by Luka Khokhiashvili on 01.07.24.
//

import UIKit

class FavoritesViewController: UIViewController {
    var selectedCategories: Set<String> = ["Favorites"]
    var filteredProductsData: [Product] = productsData
    var products: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = "Favorites"
//        setupProducts()
//        filterProducts()
//        NotificationCenter.default.addObserver(self, selector: #selector(favoriteStatusChanged(_:)), name: .favoriteStatusChanged, object: nil)
    }
    

//    private func setupProducts() {
//`        let verticalLayout = UICollectionViewFlowLayout()
//        verticalLayout.scrollDirection = .vertical
//        verticalLayout.itemSize = CGSize(width: (view.frame.width - 40) / 2 - 10, height: 200)
//        
//        products = UICollectionView(frame: .zero, collectionViewLayout: verticalLayout)
//        products.delegate = self
//        products.dataSource = self
//        products.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell2")
//        products.backgroundColor = .white
//        products.showsVerticalScrollIndicator = false
//
//        
//        view.addSubview(products)
//        
//        products.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            products.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            products.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            products.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            products.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//    
//    
//    @objc private func favoriteStatusChanged(_ notification: Notification) {
//        if notification.object is Product {
//            if selectedCategories.contains("Favorites") {
//                filterProducts()
//            }
//        }
//    }

}


//extension FavoritesViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return filteredProductsData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell2", for: indexPath) as! ProductCell
//            cell.setupProduct(product: filteredProductsData[indexPath.row])
//            return cell
//    }
//
//}
//
//extension FavoritesViewController: UICollisionBehaviorDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let productViewController = ProductViewController(prduct: filteredProductsData[indexPath.row])
//        navigationController?.pushViewController(productViewController, animated: true)
//        
//    }
//    
//    private func filterProducts() {
//        filteredProductsData = productsData.filter { product in
//            return selectedCategories.contains("Favorites") && product.isFavorite()
//            
//        }
//        products.reloadData()
//    }
//}
//
//extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width/2-10, height: 300)
//    }
//}
//

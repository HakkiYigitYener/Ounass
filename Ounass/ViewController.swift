//
//  ViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 4.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    var dataSource: [Product] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProductList()
    }
    
    func setupUI() {
        productListCollectionView.register(UINib.init(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
    }
    
    func fetchProductList(page: Int = 0)  {
        NetworkManager.shared.fetchProductList(page: 0) {productList in
            self.dataSource += productList.products
            self.productListCollectionView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ProductDetail":
            guard let vc = segue.destination as? ProductDetailViewController, let product = sender as? Product else { return }
            vc.product = product
        default: break
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = dataSource[indexPath.row]
        //TODO: Add loading
        NetworkManager.shared.fetchProductDetail(sku: product.sku) { productDetail in
            self.performSegue(withIdentifier: "ProductDetail", sender: productDetail)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let product = dataSource[indexPath.row]
        cell.setupCell(designerName: product.designerCategoryName,
                       productName: product.name,
                       price: product.price,
                       imagePath: product.media.first?.src)
        return cell
    }
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //TODO: Lazy loading
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let screenSize: CGRect = UIScreen.main.bounds
        let itemWidth = (screenSize.width - (flow.sectionInset.left + flow.sectionInset.right + flow.minimumInteritemSpacing)) / 2
        return CGSize(width: itemWidth, height: itemWidth * 2.15)
    }
}


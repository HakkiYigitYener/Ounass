//
//  ProductListViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 4.02.2022.
//

import UIKit
import ANActivityIndicator

class ProductListViewController: UIViewController {
    @IBOutlet weak var productListCollectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    let viewModel = ProductListViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleStateChanges()
        viewModel.fetchProductList()
    }
    
    func setupUI() {
        productListCollectionView.register(UINib.init(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        productListCollectionView.addSubview(refreshControl)
    }
    
    private func handleStateChanges() {
        viewModel.addChangeHandler { [weak self] (state) in
            switch state {
            case .fetching:
                self?.showIndicator(message: "Loading...", animationType: .ballRotateChase)
                break
            case .succeeded:
                self?.hideIndicator()
                self?.refreshControl.endRefreshing()
                self?.productListCollectionView.reloadData()
            case .failed(let errorMessage):
                self?.hideIndicator()
                self?.showAlertMessage(title: "Warning", message: errorMessage)
                self?.refreshControl.endRefreshing()
                self?.productListCollectionView.reloadData()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.fetchProductList(page: 0, shouldClear: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ProductDetail":
            guard let vc = segue.destination as? ProductDetailViewController, let product = sender as? Product else { return }
            vc.productSku = product.sku
        default: break
        }
    }
    
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductDetail", sender: viewModel.dataSource[indexPath.row])
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        let product = viewModel.dataSource[indexPath.row]
        cell.setupCell(designerName: product.designerCategoryName,
                       productName: product.name,
                       price: product.price,
                       imagePath: product.media.first?.src)
        return cell
    }
}

extension ProductListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxIndex = indexPaths.sorted(by: { index1, index2 in
            return index1.row > index2.row
        }).first?.row else { return }
        if maxIndex >= (viewModel.dataSource.count - 1),
           let paginationData = viewModel.paginationData,
            paginationData.currentPage < (paginationData.totalPages - 1),
            !viewModel.isFetching {
            viewModel.fetchProductList(page: paginationData.currentPage + 1)
        }
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let screenSize: CGRect = UIScreen.main.bounds
        let itemWidth = (screenSize.width - (flow.sectionInset.left + flow.sectionInset.right + flow.minimumInteritemSpacing)) / 2
        let productDescriptionViewHeight = 65.0
        let productImageAspectRatio = 1.75
        return CGSize(width: itemWidth, height: itemWidth * productImageAspectRatio + productDescriptionViewHeight)
    }
}


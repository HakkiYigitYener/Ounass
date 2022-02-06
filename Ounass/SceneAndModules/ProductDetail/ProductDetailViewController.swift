//
//  ProductDetailViewController.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import UIKit
import ImageSlideshow

class ProductDetailViewController: UIViewController {
    var productSku: String?

    
    @IBOutlet weak var productTableView: UITableView!
    let viewModel = ProductDetailViewModel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleStateChanges()
        viewModel.fetchProductList(sku: productSku)
    }
    
    func setupUI() {
        productTableView.register(UINib.init(nibName: "ProductDetailSliderCell", bundle: nil), forCellReuseIdentifier: "ProductDetailSliderCell")
        productTableView.register(UINib.init(nibName: "ProductTitleCell", bundle: nil), forCellReuseIdentifier: "ProductTitleCell")
        productTableView.register(UINib.init(nibName: "ProductAmberPointCell", bundle: nil), forCellReuseIdentifier: "ProductAmberPointCell")
        productTableView.register(UINib.init(nibName: "ProductDetailAccordionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "ProductDetailAccordionHeader")
        productTableView.register(UINib.init(nibName: "ProductDetailAccordionCell", bundle: nil), forCellReuseIdentifier: "ProductDetailAccordionCell")
    }
    
    private func handleStateChanges() {
        viewModel.addChangeHandler { [weak self] (state) in
            switch state {
            case .fetching:
                break
            case .succeeded:
                self?.productTableView.reloadData()
            case .failed(let errorMessage):
                self?.showAlertMessage(title: "Warning", message: errorMessage)
                self?.productTableView.reloadData()
            }
        }
    }
}

extension ProductDetailViewController: UITableViewDelegate {
    
}

extension ProductDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.sectionData[indexPath.section] {
        case .slider(let medias):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailSliderCell", for: indexPath) as! ProductDetailSliderCell
            cell.setupCell(medias: medias, delegate: self)
            return cell
        case .title(let designer, let name, let price):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTitleCell", for: indexPath) as! ProductTitleCell
            cell.setupCell(designerName: designer,
                           productName: name,
                           price: price)
            return cell
        case .amberPoints(let amberPoint):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductAmberPointCell", for: indexPath) as! ProductAmberPointCell
            cell.setupCell(amberPoint: amberPoint)
            return cell
        case .description(title: _ , description: let description):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailAccordionCell", for: indexPath) as! ProductDetailAccordionCell
            cell.setupCell(descriptionText: description)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch viewModel.sectionData[section] {
        case .description(title: let title , description: _):
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProductDetailAccordionHeader") as! ProductDetailAccordionHeader
            header.setupHeader(title: title, isOpen: Bool.random())
            return header
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch viewModel.sectionData[section] {
        case .description(title: _, description: _):
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
}

extension ProductDetailViewController: ProductDetailSliderCellDelegate {
    func didTapSliderImage(imageSlideView: ImageSlideshow) {
        imageSlideView.presentFullScreenController(from: self)
    }
}

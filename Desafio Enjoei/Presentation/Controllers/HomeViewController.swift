//
//  HomeViewController.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import UIKit
import SDWebImage
import SkeletonView

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var clearSearchButton: UIButton!
    @IBOutlet weak var searchBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchEmptyView: UIView!
    @IBOutlet weak var homeCollectionView: UIView!
    
    let productsCollectionViewCellId = "ProductsCollectionViewCell"
    let viewModel: HomeViewModel = HomeViewModel()
    var products: [Products] = []
    var productCount: Int = 0
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupClearSearchButton()
        setupSearchBar()
        setupEmptySearchView()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.showAnimatedSkeleton()
    }
    
    private func setupNavigationBar() {
        let navBar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 60))
        self.navigationController?.navigationBar.addSubview(navBar)
    }
    
    private func setupCollectionView() {
        let nibCell = UINib(nibName: productsCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: productsCollectionViewCellId)
        viewModel.fetchProducts(page: 1) { _ in
            self.products = self.viewModel.productsDataBase?.model ?? []
            self.productCount = self.viewModel.productsDataBase?.model.count ?? 0
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.05))
        }
    }
    
    private func setupClearSearchButton() {
        clearSearchButton.tintColor = UIColor(named: "DarkShadeMagenta")
        clearSearchButton.isHidden = true
    }
    
    private func setupSearchBar() {
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBarWidthConstraint.constant = 365
    }
    
    private func setupEmptySearchView() {
        homeCollectionView.addSubview(searchEmptyView)
        searchEmptyView.isHidden = true
    }
    
    private func configureImageViewCell(cell: ProductsCollectionViewCell, indexPath: IndexPath) {
        if let imageURL = URL(string: "https://photos.enjoei.com.br/public/500x500/\(products[safe: indexPath.row]?.imagePublicId ?? "")") {
            cell.productImage.sd_imageIndicator = SDWebImageActivityIndicator.white
            cell.productImage.sd_imageIndicator?.startAnimatingIndicator()
            cell.productImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "empty-image"), options: .continueInBackground, completed: nil)
            cell.productImage.contentMode = .scaleToFill
        } else {
            print("Invalid URL")
            cell.isHidden = true
        }
    }
    
    private func configureProductsCell(cell: ProductsCollectionViewCell, indexPath: IndexPath) {
        if products[safe: indexPath.row]?.price.sale == nil {
            cell.discountPriceLabel.text = "R$ \(String(Int(products[safe: indexPath.row]?.price.listed ?? 0)))"
            cell.realPriceLabel.isHidden = true
            cell.discountPorcentLabel.isHidden = true
            cell.discountPriceLabel.textColor = UIColor(named: "GreyMineShaft")
            cell.labelViewWidthConstraint.constant = cell.discountPriceLabel.textWidth() * 1.4
        } else {
            cell.realPriceLabel.isHidden = false
            cell.discountPriceLabel.isHidden = false
            cell.discountPorcentLabel.isHidden = false
            cell.discountPriceLabel.text = "R$ \(String(Int(products[safe: indexPath.row]?.price.sale ?? 0)))"
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "R$ \(String(Int(products[safe: indexPath.row]?.price.listed ?? 0)))")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.realPriceLabel.attributedText = attributeString
            cell.labelViewWidthConstraint.constant = cell.discountPriceLabel.textWidth() + 10
            cell.labelViewWidthConstraint.constant = (cell.discountPriceLabel.textWidth() + cell.realPriceLabel.textWidth()) * 1.2
            cell.discountPriceLabel.textColor = UIColor(named: "DarkShadeMagenta")
            cell.realPriceLabel.textColor = UIColor(named: "Gray97")
            
            let discountPorcent = ((products[safe: indexPath.row]?.price.sale ?? 0) * 100) / (products[safe: indexPath.row]?.price.listed ?? 0)
            cell.discountPorcentLabel.text = "\(Int(100 - discountPorcent))% off"
        }
    }
    
    private func clearSearch() {
        searchBar.text = ""
        products = viewModel.productsDataBase?.model ?? []
        collectionView.reloadData()
        clearSearchButton.isHidden = true
        searchBarWidthConstraint.constant = 365
        searchEmptyView.isHidden = true
    }
    
    @IBAction func clearSearchField(_ sender: UIButton) {
        clearSearch()
    }
    
    @IBAction func clearSearchEmptyButton(_ sender: UIButton) {
        clearSearch()
    }
    
}

extension HomeViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return productsCollectionViewCellId
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productsCollectionViewCellId, for: indexPath) as! ProductsCollectionViewCell
        if products[safe: indexPath.row] != nil {
            cell.isHidden = false
            configureImageViewCell(cell: cell, indexPath: indexPath)
            configureProductsCell(cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productsDataBase?.model.count ?? 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 163, height: 163)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = viewModel.productsDataBase?.model[safe: indexPath.row]
        print(product?.title ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if products.count != 0 {
            var newIndexPath = [IndexPath]()
            let item = products[indexPath.row].title
            let itemNewIndexPath = products[newIndexPath[safe: productCount]?.row ?? 0].title
            if (item == products.last?.title || itemNewIndexPath == products.last?.title) && productCount == products.count {
                viewModel.fetchProducts(page: viewModel.productsDataBase?.pagination.nextPage ?? 0) { _ in
                    guard self.viewModel.auxProducts.count > 0 else {
                        return
                    }
                    let firstNewIndex = indexPath.item + 1
                    //create new index path
                    for i in firstNewIndex...(firstNewIndex + self.viewModel.auxProducts.count - 1) {
                        newIndexPath.append(IndexPath(item: i, section: 0))
                    }
                    //concatenating your data
                    self.products = self.products + self.viewModel.auxProducts
                    self.productCount += self.viewModel.auxProducts.count
                    self.viewModel.auxProducts = []
                    // inform collection view for she adding the new cells
                    self.collectionView.performBatchUpdates({
                        self.collectionView.insertItems(at: newIndexPath)
                    }, completion: nil)
                }
                
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowerSearchText = searchText.lowercased()
        var auxHaveProduct: Bool = false
        if searchText.isEmpty {
            clearSearchButton.isHidden = true
            searchBarWidthConstraint.constant = 365
            products = viewModel.productsDataBase?.model ?? []
        } else {
            clearSearchButton.isHidden = false
            searchBarWidthConstraint.constant = 247
            products = products.filter { product -> Bool in
                if product.title.lowercased().hasPrefix(lowerSearchText) {
                    auxHaveProduct = true
                }
                return product.title.lowercased().hasPrefix(lowerSearchText)
            }
            if !auxHaveProduct {
                searchEmptyView.isHidden = false
            }
        }
        self.collectionView.reloadData()
    }
}

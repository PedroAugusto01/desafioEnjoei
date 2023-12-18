//
//  ProductsCollectionViewCell.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var viewPriceLabel: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var labelViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var discountPorcentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

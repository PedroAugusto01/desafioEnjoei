//
//  CustonNavigationBar.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 14/12/23.
//

import UIKit

class CustomNavigationBar: UIView {
    @IBOutlet weak var imageLogo: UIImageView!
    
    private let bundle = Bundle(for: CustomNavigationBar.self)
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        customInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        customInit()
    }
    
    // MARK: - Functions
    private func customInit() {
        guard
            let view = self.bundle.loadNibNamed("CustomNavigationBar",
                                                owner: self,
                                                options: nil)?.first as? UIView
        else {
            return
        }

       
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addBottomBorderWithColor(color: UIColor(named: "WhiteBorder") ?? .gray, width: 1.5)
        
        addSubview(view)
        layoutIfNeeded()
        setupUI()
    }
    
    private func setupUI() {
        self.imageLogo.image = UIImage(named: "enjoei-icon-color")
    }
}

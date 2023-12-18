//
//  C4AllProductListCollectionViewModel.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Foundation

public class AllProductListCollectionViewModel: NSObject {
    public var model: [Products]
    public var pagination: Pagination
    
    init(model: [Products], pagination: Pagination) {
        self.model = model
        self.pagination = pagination
    }
    
    func getTitle(index: Int) -> String {
        return model[safe: index]?.title ?? ""
    }
    
    func getContext(index: Int) -> String {
        return model[safe: index]?.context ?? ""
    }
    
    func getImagePublicId(index: Int) -> String {
        return model[safe: index]?.imagePublicId ?? ""
    }
    
    func getSlug(index: Int) -> String {
        return model[safe: index]?.slug ?? ""
    }
    
    func getInt(index: Int) -> Int {
        return model[safe: index]?.id ?? 0
    }
    
    func getPriceListed(index: Int) -> Double {
        return model[safe: index]?.price.listed ?? 0
    }
    
    func getPriceSale(index: Int) -> Double {
        return model[safe: index]?.price.sale ?? 0
    }
}

//
//  HomeViewModel.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Foundation

public class HomeViewModel {
    private let api = EnjoeiApi()
    public var productsDataBase: AllProductListCollectionViewModel?
    public var auxProducts: [Products] = []
    
    public init() { }
    
    public func fetchProducts(page: Int, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        api.getProducts(page: page) { result in
            switch result {
            case .success(let productResponse):
                if self.productsDataBase == nil {
                    self.productsDataBase = AllProductListCollectionViewModel(model: productResponse.products, pagination: productResponse.pagination)
                } else {
                    self.productsDataBase?.model += productResponse.products
                    self.auxProducts = productResponse.products
                    self.productsDataBase?.pagination = productResponse.pagination
                }
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}

//
//  EnjoeiApi.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Moya

public class EnjoeiApi {
    
    public init() {}
    
    let provider: MoyaProvider<EnjoeiApiType> = MoyaProvider()
    
    public func getProducts(page: Int, completionHandler: @escaping(Result<EnjoeiApiResponse, NetworkError>) -> Void) {
        self.provider.request(.getProducts(page: page)) { result in
            switch result {
            case .success(let response):
                do {
                    let productResponse = try response.map(EnjoeiApiResponse.self)
                    completionHandler(.success(productResponse))
                } catch {
                    if response.statusCode == 500 || response.statusCode == 504 {
                        completionHandler(.failure(.errorWithMessage("Tivemos um problema aqui. Por favor, tente novamente.")))
                    }
                    else {
                        completionHandler(.failure(.badJSONFormat))
                    }
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }
}

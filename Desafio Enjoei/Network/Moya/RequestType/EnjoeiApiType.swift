//
//  EnjoeiApiType.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Moya

enum EnjoeiApiType {
    case getProducts(page: Int)
}

extension EnjoeiApiType: TargetType {
    var baseURL: URL {
        switch self {
        case .getProducts(page: let page):
            URL(string: "https://www.enjoei.com.br?page=\(page)")!
        }
    }
    
    var path: String {
        switch self {
        case .getProducts(_):
            return "/api/v5/users/enjoei-pro/products/liked"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProducts(_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProducts(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getProducts(_):
            return ["Content-Type": "application/json"]
        }
    }
}

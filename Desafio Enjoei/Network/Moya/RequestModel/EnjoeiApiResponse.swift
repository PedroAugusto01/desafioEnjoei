//
//  EnjoeiApiResponse.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Foundation

public struct EnjoeiApiResponse: Decodable {
    public let products: [Products]
    public let pagination: Pagination
}

public struct Products: Decodable {
    public let context: String
    public let id: Int
    public let imagePublicId: String
    public let title: String
    public let slug: String
    public let price: Price
    
    enum CodingKeys: String, CodingKey {
        case context, id, title, slug, price
        case imagePublicId = "image_public_id"
    }
}

public struct Price: Decodable {
    public let listed: Double
    public let sale: Double?
}

public struct Pagination: Decodable {
    public let nextPage: Int
    
    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
    }
}

//
//  NetworkError.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Foundation
import Moya

public enum NetworkError: Error {
    case badURL
    case badJSONFormat
    case unknownError
    case userNotLogged
    case errorWithMessage(String)
}

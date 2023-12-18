//
//  Array+Extesion.swift
//  Desafio Enjoei
//
//  Created by Pedro Augusto Marques de Souza on 12/12/23.
//

import Foundation

extension Array {

    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}

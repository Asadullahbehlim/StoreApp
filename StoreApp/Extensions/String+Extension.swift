//
//  String+Extension.swift
//  StoreApp
//
//  Created by Asadullah Behlim on 19/04/23.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
}

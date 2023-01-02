//
//  String+Ext.swift
//  PopMovies
//
//  Created by Angela Alves on 02/01/23.
//

import Foundation

extension String {
    var sanitized: String {
        self.lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: .diacriticInsensitive, locale: .current)
    }

    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

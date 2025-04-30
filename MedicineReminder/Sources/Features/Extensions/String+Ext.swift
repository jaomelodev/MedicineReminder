//
//  String+Ext.swift
//  MedicineReminder
//
//  Created by João Melo on 05/02/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

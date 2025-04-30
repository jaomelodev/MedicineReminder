//
//  LoginBottomSheetDelegate.swift
//  MedicineReminder
//
//  Created by João Melo on 10/02/25.
//

import Foundation
import UIKit

protocol LoginBottomSheetDelegate: AnyObject {
    func sendLoginData(user: String, password: String)
}

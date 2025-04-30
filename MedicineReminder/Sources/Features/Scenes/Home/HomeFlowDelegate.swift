//
//  HomeFlowDelegate.swift
//  MedicineReminder
//
//  Created by João Melo on 17/02/25.
//

public protocol HomeFlowDelegate: AnyObject {
    func navigateToNewReceipts()
    func navigateToMyReceipts()
    func logout()
}

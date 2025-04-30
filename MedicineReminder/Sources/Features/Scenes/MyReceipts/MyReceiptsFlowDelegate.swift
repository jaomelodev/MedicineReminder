//
//  MyReceiptsFlowDelegate.swift
//  MedicineReminder
//
//  Created by João Melo on 31/03/25.
//

public protocol MyReceiptsFlowDelegate: AnyObject {
    func didTapBackButton()
    func goToNewReceipt()
}

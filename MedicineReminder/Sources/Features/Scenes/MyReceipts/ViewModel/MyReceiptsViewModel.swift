//
//  MyReceiptsViewModel.swift
//  MedicineReminder
//
//  Created by João Melo on 06/04/25.
//
import UserNotifications

class MyReceiptsViewModel {
    func fetchMyReceipts() -> [Medicine] {
        return DBHelper.shared.fetchReceipts()
    }

    func deleteReceipt(byId id: Int) {
        DBHelper.shared.deleteReceipt(byId: id)
    }

    func removeRemoveNotifications(for medicine: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<24).map { "\(medicine)_\($0)" }

        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        print("Notificações para \(identifiers) removidas com sucesso!")
    }
}

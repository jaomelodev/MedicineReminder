//
//  NewReceiptViewModel.swift
//  MedicineReminder
//
//  Created by João Melo on 19/03/25.
//
import UserNotifications

class NewReceiptViewModel {
    func addReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        DBHelper.shared.insertReceipt(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)

        scheduleNotifications(forMedicine: remedy, at: time, withInterval: recurrence)
    }

    private func scheduleNotifications(forMedicine medicine: String, at time: String, withInterval recurrence: String) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Hora de tomar o remédio!"
        content.body = "Lembre-se de tomar o \(medicine)"
        content.sound = .default

        let interval = getIntervalInHours(from: recurrence)

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"

        guard let initialDate = formatter.date(from: time) else {
            return
        }

        let calendar = Calendar.current
        var currentDate = initialDate

        for i in 0..<(24 / interval) {
            let components = calendar.dateComponents([.hour, .minute], from: currentDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

            let request = UNNotificationRequest(identifier: medicine + "_\(i)", content: content, trigger: trigger)

            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled for \(medicine)")
                }
            }

            currentDate = calendar.date(byAdding: .hour, value: interval, to: currentDate) ?? Date()
        }
    }

    private func getIntervalInHours(from recurrence: String) -> Int {
        let recurrenceMap: [String: Int] = [
            "De hora em hora": 1,
            "2 em 2 horas": 2,
            "4 em 4 horas": 4,
            "6 em 6 horas": 6,
            "8 em 8 horas": 8,
            "12 em 12 horas": 12,
            "Um por dia": 24
        ]

        return recurrenceMap[recurrence] ?? 8
    }
}

//
//  UIKitPreview.swift
//  MedicineReminder
//
//  Created by João Melo on 03/02/25.
//

#if DEBUG
import SwiftUI
import UIKit

struct UIViewPreview<T: UIView>: UIViewRepresentable {
    let view: T

    init(_ viewBuilder: @escaping () -> T) {
        view = viewBuilder()
    }

    func makeUIView(context: Context) -> T {
        return view
    }

    func updateUIView(_ uiView: T, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif

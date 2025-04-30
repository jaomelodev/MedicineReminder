//
//  Checkbox.swift
//  MedicineReminder
//
//  Created by João Melo on 16/03/25.
//

import UIKit

class Checkbox: UIView {
    private let checkboxButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.setImage(
            UIImage(systemName: "square"),
            for: .normal
        )
        button.setImage(
            UIImage(systemName: "checkmark.square.fill"),
            for: .selected
        )
        button.tintColor = Colors.gray400
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.input
        label.textColor = Colors.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(title: String) {
        super.init(frame: .zero)

        titleLabel.text = title

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.isUserInteractionEnabled = true

        addSubview(checkboxButton)
        addSubview(titleLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Metrics.size24),

            checkboxButton.heightAnchor.constraint(equalToConstant: Metrics.size24),
            checkboxButton.widthAnchor.constraint(equalToConstant: Metrics.size24),
            checkboxButton.topAnchor.constraint(equalTo: topAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: Metrics.p12),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func getValue() -> Bool {
        return checkboxButton.isSelected
    }
}

#if DEBUG
import SwiftUI

struct CheckboxPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            Checkbox(
                title: "Tomar agora"
            )
        }
        .frame(height: 24)
        .padding(.horizontal)
        .ignoresSafeArea()
    }
}
#endif

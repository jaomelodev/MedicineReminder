//
//  Input.swift
//  MedicineReminder
//
//  Created by João Melo on 16/03/25.
//
import UIKit

class Input: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = Metrics.p8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray400.cgColor
        textField.textColor = Colors.gray100
        textField.translatesAutoresizingMaskIntoConstraints = false

        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.p16, height: 0))
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always

        return textField
    }()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)

        titleLabel.text = title
        configurePlaceholder(placeholder: placeholder)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configurePlaceholder(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.gray200,
                .font: Typography.input
            ]
        )
    }

    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 85),

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.p12),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        ])
    }

    func getText() -> String {
        return textField.text ?? ""
    }
}

#if DEBUG
import SwiftUI

struct InputPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            Input(
                title: "Remédio", placeholder: "Nome do medicamento"
            )
        }
        .frame(height: 85)
        .padding(.horizontal)
        .ignoresSafeArea()
    }
}
#endif

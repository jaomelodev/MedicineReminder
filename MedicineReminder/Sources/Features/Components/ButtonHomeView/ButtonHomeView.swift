//
//  ButtonHomeView.swift
//  MedicineReminder
//
//  Created by João Melo on 14/03/25.
//

import UIKit

class ButtonHomeView: UIView {
    var tapAction: (() -> Void)?

    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = Metrics.p8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray100
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.spacing = Metrics.p8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray300
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(icon: UIImage?, title: String, description: String) {
        super.init(frame: .zero)

        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description

        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = Colors.gray700
        self.layer.cornerRadius = Metrics.p12
        self.layer.borderColor = Colors.gray600.cgColor
        self.layer.borderWidth = 1

        iconView.addSubview(iconImageView)
        addSubview(iconView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)

        addSubview(arrowImageView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 112),

            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p16),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: Metrics.size80),
            iconView.heightAnchor.constraint(equalToConstant: Metrics.size80),

            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Metrics.size48),
            iconImageView.heightAnchor.constraint(equalToConstant: Metrics.size48),

            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.p16),

            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p12),

            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Metrics.p16),
            arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p16),
            arrowImageView.widthAnchor.constraint(equalToConstant: Metrics.size20),
            arrowImageView.heightAnchor.constraint(equalToConstant: Metrics.size20)
        ])
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }

    @objc
    private func handleTap() {
        tapAction?()
    }
}

#if DEBUG
import SwiftUI

struct ButtonHomeViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            ButtonHomeView(
                icon: UIImage(named: "pills"),
                title: "Nova receita",
                description: "Cadastre novos lembretes de receitas"
            )
        }
        .frame(height: 112)
        .padding(.horizontal)
        .ignoresSafeArea()
    }
}
#endif

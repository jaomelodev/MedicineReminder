//
//  HomeView.swift
//  MedicineReminder
//
//  Created by João Melo on 17/02/25.
//
import Foundation
import UIKit

class HomeView: UIView {
    public weak var delegate: HomeDelegate?

    private let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let userImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = Colors.primaryBlueBase.cgColor
        imageView.layer.borderWidth = 1.5
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var logoutButton: UIButton = {
        let imageView = UIImageView(image: UIImage(named: "Logout"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryRedBase
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton()
        button.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray200
        label.font = Typography.input
        label.text = "home.label.welcome".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = Colors.gray100
        textField.font = Typography.heading
        textField.placeholder = "home.textfield.name.placeholder".localized
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let menuContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray800
        view.layer.cornerRadius = Metrics.p24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let myPrescriptionsButton: ButtonHomeView = {
        let buttonHomeView = ButtonHomeView(
            icon: UIImage(named: "paper"),
            title: "home.homeButton.myReceipts.title".localized,
            description: "home.homeButton.myReceipts.description".localized
        )
        buttonHomeView.translatesAutoresizingMaskIntoConstraints = false
        return buttonHomeView
    }()

    let newPrescriptionButton: ButtonHomeView = {
        let buttonHomeView = ButtonHomeView(
            icon: UIImage(named: "pills"),
            title: "home.homeButton.newReceipt.title".localized,
            description: "home.homeButton.newReceipt.description".localized
        )
        buttonHomeView.translatesAutoresizingMaskIntoConstraints = false
        return buttonHomeView
    }()

    private let feedbackButton: UIButton = {
        let image = UIImage(named: "star")?.withTintColor(Colors.gray800, renderingMode: .alwaysOriginal)

        let button = UIButton()
        button.setTitle("home.button.rate".localized, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.gray100
        button.layer.cornerRadius = 28
        button.setTitleColor(Colors.gray800, for: .normal)
        button.setImage(image, for: .normal)
        button.configuration?.imagePadding = 80
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        setupImageGesture()

        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = Colors.gray600

        addSubview(userImageView)
        addSubview(logoutButton)
        addSubview(welcomeLabel)
        addSubview(userNameTextField)
        addSubview(menuContainerView)

        menuContainerView.addSubview(myPrescriptionsButton)
        menuContainerView.addSubview(newPrescriptionButton)
        menuContainerView.addSubview(feedbackButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.heightAnchor.constraint(equalToConstant: 64),
            userImageView.widthAnchor.constraint(equalToConstant: 64),
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.p32),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.p32),

            logoutButton.heightAnchor.constraint(equalToConstant: Metrics.size24),
            logoutButton.widthAnchor.constraint(equalToConstant: Metrics.size24),
            logoutButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.p32),
            logoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.p32),

            welcomeLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: Metrics.p16),
            welcomeLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),

            userNameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.p4),
            userNameTextField.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),

            menuContainerView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: Metrics.p32),
            menuContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            myPrescriptionsButton.topAnchor.constraint(equalTo: menuContainerView.topAnchor, constant: Metrics.p40),
            myPrescriptionsButton.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor, constant: Metrics.p32),
            myPrescriptionsButton.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor, constant: -Metrics.p32),

            newPrescriptionButton.topAnchor.constraint(equalTo: myPrescriptionsButton.bottomAnchor, constant: Metrics.p16),
            newPrescriptionButton.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor, constant: Metrics.p32),
            newPrescriptionButton.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor, constant: -Metrics.p32),

            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.size56),
            feedbackButton.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor, constant: Metrics.p32),
            feedbackButton.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor, constant: -Metrics.p32),
            feedbackButton.bottomAnchor.constraint(equalTo: menuContainerView.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.p14)
        ])
    }

    private func setupImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))

        userImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }

    private func setupTextField() {
        userNameTextField.addTarget(
            self,
            action: #selector(userNameTextFieldDidEndEditing),
            for: .editingDidEnd
        )

        userNameTextField.delegate = self
    }

    @objc
    private func userNameTextFieldDidEndEditing() {
        let userName = userNameTextField.text ?? ""
        UserDefaultsManager.saveUserName(userName)
    }

    @objc
    private func logout() {
        delegate?.logout()
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

#if DEBUG
import SwiftUI

struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            HomeView()
        }
        .ignoresSafeArea()
    }
}
#endif

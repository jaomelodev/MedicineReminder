//
//  LoginBottomSheetView.swift
//  MedicineReminder
//
//  Created by João Melo on 05/02/25.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    public weak var delegate: LoginBottomSheetDelegate?

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let totalHeight = loginButton.frame.maxY + Metrics.p48
        return CGSize(width: UIView.noIntrinsicMetric, height: totalHeight)
    }

    private let handleArea: UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.p4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "login.label.title".localized
        label.font = Typography.subHeading
        label.textColor = Colors.gray100
        // Used to enable user interaction to detect a tap for example
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "login.label.email".localized
        label.font = Typography.label
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "login.email.placeholder".localized,
            attributes: [
                .foregroundColor: Colors.gray200,
                .font: Typography.input
            ]
        )
        textField.layer.cornerRadius = Metrics.p8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray400.cgColor
        textField.keyboardType = .emailAddress
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

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "login.label.password".localized
        label.font = Typography.label
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordEyeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "eye"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let passwordEyeContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        return containerView
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = Metrics.p8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray400.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = Colors.gray100
        textField.translatesAutoresizingMaskIntoConstraints = false

        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.p16, height: 0))
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightViewMode = .always

        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button.title".localized, for: .normal)
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        button.titleLabel?.font = Typography.subHeading
        button.tintColor = Colors.gray800
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

        setupTogglePasswordSecureTextGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.p24
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        // addSubview(handleArea)
        addSubview(titleLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)

        passwordEyeContainerView.addSubview(passwordEyeImageView)
        passwordTextField.rightView = passwordEyeContainerView

        setupConstraints()

        setupDelegates()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            passwordEyeContainerView.widthAnchor.constraint(equalToConstant: Metrics.size40),
            passwordEyeContainerView.heightAnchor.constraint(equalToConstant: Metrics.size24),

            passwordEyeImageView.centerYAnchor.constraint(equalTo: passwordEyeContainerView.centerYAnchor),
            passwordEyeImageView.trailingAnchor.constraint(equalTo: passwordEyeContainerView.trailingAnchor, constant: -Metrics.p16),
            passwordEyeImageView.widthAnchor.constraint(equalToConstant: Metrics.size24),
            passwordEyeImageView.heightAnchor.constraint(equalToConstant: Metrics.size24)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.p48),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),

            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.p40),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),

            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Metrics.p12),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p24),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.size56),

            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.p20),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Metrics.p12),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p24),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.size56),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Metrics.p40),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p24),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p24),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.size56)
        ])
    }

    private func setupTogglePasswordSecureTextGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(togglePasswordSecureText))
        passwordEyeContainerView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func togglePasswordSecureText() {
        if let newEyeImage = UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.slash" : "eye") {
            passwordEyeImageView.setSymbolImage(newEyeImage, contentTransition: .replace)
        }

        let existingText = passwordTextField.text
        passwordTextField.text = ""
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.text = existingText

        let animationDuration = 0.2
        UIView.transition(with: passwordTextField, duration: animationDuration, options: .transitionCrossDissolve, animations: nil)
    }

    @objc
    private func loginButtonDidTapped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        delegate?.sendLoginData(user: email, password: password)
    }

    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension LoginBottomSheetView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

#if DEBUG
import SwiftUI

struct LoginBottomSheetViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            return LoginBottomSheetView()
        }
    }
}
#endif

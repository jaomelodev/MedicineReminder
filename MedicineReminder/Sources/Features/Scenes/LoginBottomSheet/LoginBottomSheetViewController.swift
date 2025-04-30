//
//  LoginBottomSheetViewController.swift
//  MedicineReminder
//
//  Created by João Melo on 05/02/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    let contentView: LoginBottomSheetView

    let viewModel = LoginBottomSheetViewModel()
    var animateSplashLogoUp: ((CGFloat) -> Void)?
    var animateSplashLogoBack: (() -> Void)?

    public weak var flowDelegate: LoginBottomSheetFlowDelegate?

    init(
        contentView: LoginBottomSheetView,
        flowDelegate: LoginBottomSheetFlowDelegate
    ) {
        self.flowDelegate = flowDelegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.delegate = self

        setupUI()
        setupGesture()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }

    private func setupUI() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func setupGesture() {
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        self.view.addGestureRecognizer(tapGestureBackground)
    }

    @objc
    func backgroundTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    private func bindViewModel() {
        viewModel.successResult = { [weak self] usernameLogin in
            self?.presentSaveLoginAlert(email: usernameLogin)
        }

        viewModel.errorResult = { [weak self] errorMessage in
            self?.presentErrorAlert(message: errorMessage)
        }
    }

    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(
            title: "Salvar Acesso",
            message: "Deseja salvar seu acesso?",
            preferredStyle: .alert
        )

        let saveAction = UIAlertAction(
            title: "Salvar",
            style: .default) { _ in
                let user = User(email: email, isUserSaved: true)

                UserDefaultsManager.saveUser(user: user)

                self.animateDismiss()
            }

        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            self.animateDismiss()
        }

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true)
    }

    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(
            title: "Erro ao executar login",
            message: message,
            preferredStyle: .alert
        )

        let retryAction = UIAlertAction(title: "Tentar novamente", style: .default)

        alertController.addAction(retryAction)

        self.present(alertController, animated: true)
    }

    internal func animateShow(
        animateSplashLogoBack: (() -> Void)? = nil,
        completion: ((CGFloat) -> Void)? = nil
    ) {
        self.view.layoutIfNeeded()

        let loginFrameHeight = contentView.intrinsicContentSize.height

        contentView.transform = CGAffineTransform(translationX: 0, y: loginFrameHeight)

        if let completion = completion {
            self.animateSplashLogoUp = completion
        }

        self.animateSplashLogoUp?(loginFrameHeight)

        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        })

        if let animateSplashLogoBack = animateSplashLogoBack {
            self.animateSplashLogoBack = animateSplashLogoBack
        }
    }

    private func animateDismiss() {
        self.animateSplashLogoBack?()

        let loginFrameHeight = contentView.intrinsicContentSize.height

        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: loginFrameHeight)
            self.view.layoutIfNeeded()
        }) { _ in
            self.flowDelegate?.navigateToHome()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.doAuth(usernameLogin: user, password: password)
    }
}

#if DEBUG
import SwiftUI

struct LoginBottomSheetViewController_Preview: PreviewProvider {
    private static let flowController: MedicineReminderFlowController = {
        let flowController = MedicineReminderFlowController()
        _ = flowController.startFlow()
        return flowController
    }()

    static var previews: some View {
        UIViewControllerPreview {
            LoginBottomSheetViewController(
                contentView: LoginBottomSheetView(),
                flowDelegate: flowController
            )
        }
        .background(Color(Colors.primaryRedBase))
        .ignoresSafeArea()
    }
}
#endif

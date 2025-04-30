//
//  HomeViewController.swift
//  MedicineReminder
//
//  Created by João Melo on 17/02/25.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    let viewModel: HomeViewModel

    weak var flowDelegate: HomeFlowDelegate?

    init(contentView: HomeView, flowDelegate: HomeFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        self.viewModel = HomeViewModel()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        setupActions()

        checkForExistingData()
    }

    private func setup() {
        self.view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray600

        contentView.delegate = self

        setupConstraints()
    }

    private func setupConstraints() {
        setupContentViewToBounds(contentView: contentView)
    }

    private func setupNavigationBar() {
        // You can set the logout button in the navigationBar, but for style purposes, I added it in the view

        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true

        let logoutButton = UIBarButtonItem(
            image: UIImage(named: "Logout"),
            style: .plain,
            target: self,
            action: #selector(logoutAction)
        )
        logoutButton.tintColor = Colors.primaryRedBase

        navigationItem.rightBarButtonItem = logoutButton
    }

    @objc
    private func logoutAction() {

    }

    private func setupActions() {
        contentView.myPrescriptionsButton.tapAction = { [weak self] in
            self?.ditTapMyReceipts()
        }

        contentView.newPrescriptionButton.tapAction = { [weak self] in
            self?.didTapNewReceipt()
        }
    }

    private func checkForExistingData() {
        contentView.userNameTextField.text = UserDefaultsManager.loadUserName()

        if let imageData = UserDefaultsManager.loadUserImage() {
            contentView.userImageView.image = UIImage(data: imageData)
        }
    }
}

extension HomeViewController: HomeDelegate {
    func didTapProfileImage() {
        selectProfileImage()
    }

    func ditTapMyReceipts() {
        self.flowDelegate?.navigateToMyReceipts()
    }

    func didTapNewReceipt() {
        self.flowDelegate?.navigateToNewReceipts()
    }

    func logout() {
        UserDefaultsManager.removeUser()
        self.flowDelegate?.logout()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    internal func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage

        if let image = image {
            contentView.userImageView.image = image

            guard let imageData = image.jpegData(compressionQuality: 0.7) else { return }

            UserDefaultsManager.saveUserImage(imageData)
        }

        dismiss(animated: true)
    }

    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

#if DEBUG
import SwiftUI

struct HomeViewControllerPreview: PreviewProvider {
    private static let flowController: MedicineReminderFlowController = {
        let flowController = MedicineReminderFlowController()
        _ = flowController.startFlow()
        return flowController
    }()

    static var previews: some View {
        UIViewControllerPreview {
            HomeViewController(
                contentView: HomeView(),
                flowDelegate: self.flowController
            )
        }
        .ignoresSafeArea()
    }
}
#endif

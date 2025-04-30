//
//  NewReceiptController.swift
//  MedicineReminder
//
//  Created by João Melo on 16/03/25.
//

import Foundation
import UIKit
import Lottie

class NewReceiptViewController: UIViewController {
    private let successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.isHidden = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()

    private let contentView: NewReceiptView
    private let viewModel = NewReceiptViewModel()

    weak var flowDelegate: NewReceiptFlowDelegate?

    init(contentView: NewReceiptView, flowDelegate: NewReceiptFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }

    private func setupView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray800

        view.addSubview(contentView)
        view.addSubview(successAnimationView)

        setupConstraints()
    }

    private func setupConstraints() {
        setupContentViewToBounds(contentView: contentView)

        NSLayoutConstraint.activate([
            successAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupActions() {
        contentView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }

    @objc
    private func didTapBackButton() {
        self.flowDelegate?.goBackToHome()
    }

    @objc
    private func didTapAddButton() {
        let medicine = contentView.medicineInput.getText()
        let recurrence = contentView.recurrenceInput.getText()
        let time = contentView.timeInput.getText()
        let takeNow = contentView.takeNow.getValue()

        viewModel.addReceipt(remedy: medicine,
                             time: time,
                             recurrence: recurrence,
                             takeNow: takeNow)

        playSuccessAnimation()

        print("receita \(medicine) adicionada")
    }

    private func playSuccessAnimation() {
        successAnimationView.isHidden = false
        successAnimationView.play { [weak self] finished in
            if finished {
                self?.successAnimationView.isHidden = true
                self?.clearFieldsAndResetButton()
            }
        }
    }

    private func clearFieldsAndResetButton() {
        contentView.medicineInput.textField.text = ""
        contentView.timeInput.textField.text = ""
        contentView.recurrenceInput.textField.text = ""
        contentView.addButton.isEnabled = false
    }
}

#if DEBUG
import SwiftUI

struct NewReceiptViewControllerPreview: PreviewProvider {
    private static let flowController: MedicineReminderFlowController = {
        let flowController = MedicineReminderFlowController()
        _ = flowController.startFlow()
        return flowController
    }()

    static var previews: some View {
        UIViewControllerPreview {
            NewReceiptViewController(
                contentView: NewReceiptView()
            )
        }
        .ignoresSafeArea()
    }
}
#endif

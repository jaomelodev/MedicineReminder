//
//  SplashViewController.swift
//  MedicineReminder
//
//  Created by João Melo on 03/02/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView

    public weak var flowDelegate: SplashFlowDelegate?

    init(
        contentView: SplashView,
        flowDelegate: SplashFlowDelegate
    ) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        startBreathingAnimation()
    }

    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.primaryRedBase

        setupConstraints()
    }

    private func setupConstraints() {
        setupContentViewToBounds(contentView: contentView)
    }

    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.loadUser(), user.isUserSaved {
            self.flowDelegate?.navigateToHome()
        } else {
            self.showLoginBottomSheet()
        }
    }

    private func showLoginBottomSheet() {
        flowDelegate?.presentLoginBottomSheet(animateSplashLogoBack: self.animateSplashLogoBack) { loginViewHeight in
            let imageHeight: CGFloat = 48
            let remainingSpace = self.view.frame.height - loginViewHeight
            let paddingBottom = (remainingSpace / 2) - imageHeight

            self.animateLogo(paddingBottom: paddingBottom)
        }
    }
}

// MARK: - Animations
extension SplashViewController {
    private func startBreathingAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0.0, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            self.decideNavigationFlow()
        })
    }

    private func animateLogo(paddingBottom: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.contentView.updateLogoPosition(paddingBottom: paddingBottom)
            self.view.layoutIfNeeded()
        })
    }

    private func animateSplashLogoBack() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.contentView.returnLogoToInitialPosition()
            self.view.layoutIfNeeded()
        })
    }
}

#if DEBUG
import SwiftUI

struct SplashViewControllerPreview: PreviewProvider {
    private static let flowController: MedicineReminderFlowController = {
        let flowController = MedicineReminderFlowController()
        _ = flowController.startFlow()
        return flowController
    }()

    static var previews: some View {
        UIViewControllerPreview {
            SplashViewController(
                contentView: SplashView(),
                flowDelegate: self.flowController
            )
        }
        .ignoresSafeArea()
    }
}
#endif

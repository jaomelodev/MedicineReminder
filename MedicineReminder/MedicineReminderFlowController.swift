//
//  MedicineReminderFlowController.swift
//  MedicineReminder
//
//  Created by João Melo on 12/02/25.
//
import UIKit

class MedicineReminderFlowController {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllersFactory: ViewControllersFactoryProtocol
    // private let viewControllersFactory

    // MARK: - init
    public init() {
        self.viewControllersFactory = ViewControllersFactory()
    }

    // MARK: - startFlow
    func startFlow() -> UINavigationController? {
        let startViewController = viewControllersFactory.makeSplashViewController(flowDelegate: self)

        self.navigationController = UINavigationController(rootViewController: startViewController)

        return self.navigationController
    }
}

// MARK: - Splash
extension MedicineReminderFlowController: SplashFlowDelegate {
    func presentLoginBottomSheet(animateSplashLogoBack: @escaping (() -> Void), updateSplashLogo: @escaping ((CGFloat) -> Void)) {
        let loginBottomSheetViewController = viewControllersFactory.makeLoginBottomSheetViewController(flowDelegate: self)

        loginBottomSheetViewController.modalPresentationStyle = .overCurrentContext
        loginBottomSheetViewController.modalTransitionStyle = .crossDissolve

        self.navigationController?.present(loginBottomSheetViewController, animated: false) {
            loginBottomSheetViewController.animateShow(animateSplashLogoBack: animateSplashLogoBack, completion: updateSplashLogo)
        }
    }
}

// MARK: - Login
extension MedicineReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        let homeViewController = viewControllersFactory.makeHomeViewController(flowDelegate: self)

        self.navigationController?.dismiss(animated: false) {
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}

// MARK: - Home
extension MedicineReminderFlowController: HomeFlowDelegate {
    func navigateToMyReceipts() {
        let myReceiptsViewController = viewControllersFactory.makeMyReceiptsViewController(flowDelegate: self)
        self.navigationController?.pushViewController(myReceiptsViewController, animated: true)
    }

    func navigateToNewReceipts() {
        let receiptsViewController = viewControllersFactory.makeNewReceiptViewController(flowDelegate: self)
        self.navigationController?.pushViewController(receiptsViewController, animated: true)
    }

    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - New Receipt
extension MedicineReminderFlowController: NewReceiptFlowDelegate {
    func goBackToHome() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - My Receipts
extension MedicineReminderFlowController: MyReceiptsFlowDelegate {
    func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func goToNewReceipt() {
        let receiptsViewController = viewControllersFactory.makeNewReceiptViewController(flowDelegate: self)
        self.navigationController?.pushViewController(receiptsViewController, animated: true)
    }
}

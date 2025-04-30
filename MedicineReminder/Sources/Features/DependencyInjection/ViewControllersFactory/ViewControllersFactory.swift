//
//  ViewControllersFactory.swift
//  MedicineReminder
//
//  Created by João Melo on 15/02/25.
//

import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()

        let viewController = SplashViewController(
            contentView: contentView,
            flowDelegate: flowDelegate
        )

        return viewController
    }

    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()

        let viewController = LoginBottomSheetViewController(
            contentView: contentView,
            flowDelegate: flowDelegate
        )

        return viewController
    }

    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()

        let viewController = HomeViewController(
            contentView: contentView,
            flowDelegate: flowDelegate
        )

        return viewController
    }

    func makeNewReceiptViewController(flowDelegate: NewReceiptFlowDelegate) -> NewReceiptViewController {
        let contentView = NewReceiptView()

        let viewController = NewReceiptViewController(contentView: contentView, flowDelegate: flowDelegate)

        return viewController
    }

    func makeMyReceiptsViewController(flowDelegate: MyReceiptsFlowDelegate) -> MyReceiptsViewController {
        let contentView = MyReceiptsView()

        let viewController = MyReceiptsViewController(contentView: contentView, flowDelegate: flowDelegate)

        return viewController
    }
}

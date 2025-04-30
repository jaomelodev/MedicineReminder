//
//  ViewControllersFactoryProtocol.swift
//  MedicineReminder
//
//  Created by João Melo on 15/02/25.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makeNewReceiptViewController(flowDelegate: NewReceiptFlowDelegate) -> NewReceiptViewController
    func makeMyReceiptsViewController(flowDelegate: MyReceiptsFlowDelegate) -> MyReceiptsViewController
}

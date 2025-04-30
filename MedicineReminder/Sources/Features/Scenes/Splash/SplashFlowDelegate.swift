//
//  SplashFlowDelegate.swift
//  MedicineReminder
//
//  Created by João Melo on 12/02/25.
//
import UIKit

public protocol SplashFlowDelegate: AnyObject {
    func presentLoginBottomSheet(animateSplashLogoBack: @escaping (() -> Void), updateSplashLogo: @escaping ((CGFloat) -> Void))
    func navigateToHome()
}

//
//  SplashView.swift
//  MedicineReminder
//
//  Created by João Melo on 03/02/25.
//

import Foundation
import UIKit

class SplashView: UIView {

    private var logoImageViewCenterYConstraint: NSLayoutConstraint?
    private var logoImageViewHeightConstraint: NSLayoutConstraint?
    private var logoImageViewWidthConstraint: NSLayoutConstraint?

    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(logoImageView)

        setupConstraints()
    }

    private func setupConstraints() {
        self.logoImageViewCenterYConstraint = logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        self.logoImageViewHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 60)
        self.logoImageViewHeightConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 255)

        self.logoImageViewHeightConstraint?.isActive = true
        self.logoImageViewWidthConstraint?.isActive = true
        self.logoImageViewCenterYConstraint?.isActive = true

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func updateLogoPosition(paddingBottom: CGFloat) {
        self.logoImageViewCenterYConstraint?.constant = -paddingBottom
        self.logoImageViewHeightConstraint?.constant = 48
        self.logoImageViewHeightConstraint?.constant = 204
    }

    func returnLogoToInitialPosition() {
        self.logoImageViewCenterYConstraint?.constant = 0
        self.logoImageViewHeightConstraint?.constant = 60
        self.logoImageViewHeightConstraint?.constant = 255
    }
}

#if DEBUG
import SwiftUI

struct SplashViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            SplashView()
        }
        .background(Color(Colors.primaryRedBase))
    }
}
#endif

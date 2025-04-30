//
//  MyReceiptsView.swift
//  MedicineReminder
//
//  Created by João Melo on 31/03/25.
//

import UIKit

class MyReceiptsView: UIView {
    weak public var delegate: MyReceiptsViewDelegate?

    lazy var addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "plus")
        button.setImage(image, for: .normal)
        button.backgroundColor = Colors.primaryBlueBase
        button.layer.cornerRadius = Metrics.p20
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()

        let image = UIImage(named: "arrowLeft")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas Receitas"
        label.textColor = Colors.primaryBlueBase
        label.font = Typography.heading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes"
        label.textColor = Colors.gray200
        label.font = Typography.body
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let receiptsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray800
        view.layer.cornerRadius = Metrics.p32
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(addButton)
        addSubview(backButton)

        addSubview(titleLabel)
        addSubview(subtitleLabel)

        addSubview(receiptsContainerView)

        receiptsContainerView.addSubview(tableView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.p32),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.size40),
            addButton.widthAnchor.constraint(equalToConstant: Metrics.size40),

            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.p32),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.size24),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.size24),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.p24),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.p8),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            receiptsContainerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Metrics.p24),
            receiptsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            receiptsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            receiptsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: receiptsContainerView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: receiptsContainerView.leadingAnchor, constant: Metrics.p32),
            tableView.trailingAnchor.constraint(equalTo: receiptsContainerView.trailingAnchor, constant: -Metrics.p32),
            tableView.bottomAnchor.constraint(equalTo: receiptsContainerView.bottomAnchor)
        ])
    }

    @objc
    private func didTapBackButton() {
        self.delegate?.didTapBackButton()
    }

    @objc
    private func didTapAddButton() {
        self.delegate?.didTapAddButton()
    }
}

protocol MyReceiptsViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapAddButton()
}

#if DEBUG
import SwiftUI

struct MyReceiptsViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            MyReceiptsView()
        }
        .ignoresSafeArea()
        .background(Color(Colors.gray600))
    }
}
#endif

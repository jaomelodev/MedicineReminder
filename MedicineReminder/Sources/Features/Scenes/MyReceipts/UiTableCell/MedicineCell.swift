//
//  UiTableCell.swift
//  MedicineReminder
//
//  Created by João Melo on 01/04/25.
//

import UIKit

class MedicineCell: UITableViewCell {
    static let identifier = "medicineCell"

    var onDelete: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var trashButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "trash")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc
    private func trashButtonTapped() {
        self.onDelete?()
    }

    private let timeBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = Metrics.p14
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let clockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "clock"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recurrenceBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = Metrics.p14
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let recurrenceImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "repeat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let recurrenceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = Colors.gray700
        contentView.layer.cornerRadius = Metrics.p12
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = Colors.gray600.cgColor
        contentView.layer.borderWidth = 1

        contentView.addSubview(titleLabel)
        contentView.addSubview(trashButton)

        contentView.addSubview(timeBackgroundView)
        timeBackgroundView.addSubview(clockImageView)
        timeBackgroundView.addSubview(timeLabel)

        contentView.addSubview(recurrenceBackgroundView)
        recurrenceBackgroundView.addSubview(recurrenceImageView)
        recurrenceBackgroundView.addSubview(recurrenceLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.p16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.p16),

            trashButton.widthAnchor.constraint(equalToConstant: Metrics.size16),
            trashButton.heightAnchor.constraint(equalToConstant: Metrics.size16),
            trashButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.p16),

            timeBackgroundView.heightAnchor.constraint(equalToConstant: Metrics.size28),
            timeBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.p12),
            timeBackgroundView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            clockImageView.heightAnchor.constraint(equalToConstant: Metrics.size14),
            clockImageView.widthAnchor.constraint(equalToConstant: Metrics.size14),
            clockImageView.centerYAnchor.constraint(equalTo: timeBackgroundView.centerYAnchor),
            clockImageView.leadingAnchor.constraint(equalTo: timeBackgroundView.leadingAnchor, constant: Metrics.p8),

            timeLabel.centerYAnchor.constraint(equalTo: timeBackgroundView.centerYAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor, constant: Metrics.p8),
            timeLabel.trailingAnchor.constraint(equalTo: timeBackgroundView.trailingAnchor, constant: -Metrics.p8),

            recurrenceBackgroundView.heightAnchor.constraint(equalToConstant: Metrics.size28),
            recurrenceBackgroundView.topAnchor.constraint(equalTo: timeBackgroundView.topAnchor),
            recurrenceBackgroundView.leadingAnchor.constraint(equalTo: timeBackgroundView.trailingAnchor, constant: Metrics.p8),

            recurrenceImageView.heightAnchor.constraint(equalToConstant: Metrics.size14),
            recurrenceImageView.widthAnchor.constraint(equalToConstant: Metrics.size14),
            recurrenceImageView.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
            recurrenceImageView.leadingAnchor.constraint(equalTo: recurrenceBackgroundView.leadingAnchor, constant: Metrics.p8),

            recurrenceLabel.centerYAnchor.constraint(equalTo: recurrenceBackgroundView.centerYAnchor),
            recurrenceLabel.leadingAnchor.constraint(equalTo: recurrenceImageView.trailingAnchor, constant: Metrics.p8),
            recurrenceLabel.trailingAnchor.constraint(equalTo: recurrenceBackgroundView.trailingAnchor, constant: -Metrics.p8),

            contentView.bottomAnchor.constraint(equalTo: recurrenceBackgroundView.bottomAnchor, constant: Metrics.p16)
        ])
    }

    func configure(title: String, time: String, recurrence: String) {
        titleLabel.text = title
        timeLabel.text = time
        recurrenceLabel.text = recurrence
    }
}

#if DEBUG
import SwiftUI

struct MedicineCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            MedicineCell()
        }
        .ignoresSafeArea()
        .frame(height: 90)
        .padding(.horizontal)
    }
}
#endif

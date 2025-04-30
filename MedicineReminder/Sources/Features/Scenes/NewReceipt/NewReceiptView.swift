//
//  NewReceiptView.swift
//  MedicineReminder
//
//  Created by João Melo on 16/03/25.
//
import UIKit

class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.heading
        label.textColor = Colors.primaryRedBase
        label.text = "newReceipt.label.title".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.text = "newReceipt.label.description".localized
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let medicineInput: Input = {
        let input = Input(
            title: "Remédio", placeholder: "Nome do medicamento"
        )
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()

    let timeInput: Input = {
        let input = Input(
            title: "Horário", placeholder: "00:00"
        )
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()

    let recurrenceInput: Input = {
        let input = Input(
            title: "Recorrência", placeholder: "Selecione"
        )
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()

    let takeNow: Checkbox = {
        let checkbox = Checkbox(
            title: "Tomar agora"
        )
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()

    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    let recurrencePicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    let recurrenceOptions = [
        "De hora em hora",
        "2 em 2 horas",
        "4 em 4 horas",
        "6 em 6 horas",
        "8 em 8 horas",
        "12 em 12 horas",
        "Um por dia"
    ]

    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("newReceipt.button.add".localized, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = button.isEnabled ? Colors.primaryRedBase : Colors.gray500
        button.layer.cornerRadius = Metrics.p28
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        addSubview(medicineInput)
        addSubview(timeInput)
        addSubview(recurrenceInput)
        addSubview(takeNow)

        addSubview(addButton)

        setupConstraints()
        setupRecurrenceInput()
        setupTimeInput()

        setupObservers()
        validateInputs()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.p32),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.size24),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.size24),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.p24),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.p8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            medicineInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.p40),
            medicineInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            medicineInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            timeInput.topAnchor.constraint(equalTo: medicineInput.bottomAnchor, constant: Metrics.p20),
            timeInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            timeInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.p20),
            recurrenceInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            recurrenceInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),

            takeNow.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: Metrics.p20),
            takeNow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),

            addButton.heightAnchor.constraint(equalToConstant: Metrics.size56),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.p32),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.p32),
            addButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.p32)
        ])
    }

    private func setupTimeInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectTime))
        toolbar.setItems([doneButton], animated: true)

        timeInput.textField.inputView = timePicker
        timeInput.textField.inputAccessoryView = toolbar
    }

    @objc
    private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder()
        validateInputs()
    }

    private func setupRecurrenceInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectRecurrence))
        toolbar.setItems([doneButton], animated: true)

        recurrenceInput.textField.inputView = recurrencePicker
        recurrenceInput.textField.inputAccessoryView = toolbar

        recurrencePicker.delegate = self
        recurrencePicker.dataSource = self
    }

    @objc
    private func didSelectRecurrence() {
        let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = recurrenceOptions[selectedRow]

        recurrenceInput.textField.resignFirstResponder()
        validateInputs()
    }

    private func setupObservers() {
        medicineInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        timeInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        recurrenceInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    @objc
    private func inputDidChange() {
        validateInputs()
    }

    private func validateInputs() {
        let isMedicineFilled = !(medicineInput.textField.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
        let isRecurrenceFilled = !(recurrenceInput.textField.text ?? "").isEmpty

        addButton.isEnabled = isMedicineFilled && isTimeFilled && isRecurrenceFilled
        addButton.backgroundColor = addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }
}

extension NewReceiptView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurrenceOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recurrenceOptions[row]
    }
}

#if DEBUG
import SwiftUI

struct NewReceiptViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            NewReceiptView()
        }
        .ignoresSafeArea()
    }
}
#endif

//
//  Untitled.swift
//  MedicineReminder
//
//  Created by João Melo on 31/03/25.
//

import UIKit

class MyReceiptsViewController: UIViewController {
    let contentView: MyReceiptsView
    let viewModel: MyReceiptsViewModel = .init()

    weak var flowDelegate: MyReceiptsFlowDelegate?

    private var medicines: [Medicine] = []

    init(contentView: MyReceiptsView, flowDelegate: MyReceiptsFlowDelegate) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.contentView.delegate = self

        setupUI()
        setupTableView()
        loadData()
    }

    private func setupUI() {
        view.backgroundColor = Colors.gray600

        view.addSubview(contentView)

        setupConstraints()
    }

    private func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false

        setupContentViewToBounds(contentView: contentView)
    }

    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(MedicineCell.self, forCellReuseIdentifier: MedicineCell.identifier)
        contentView.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

    private func loadData() {
        medicines = viewModel.fetchMyReceipts()
    }
}

extension MyReceiptsViewController: MyReceiptsViewDelegate {
    func didTapBackButton() {
        self.flowDelegate?.didTapBackButton()
    }

    func didTapAddButton() {
        self.flowDelegate?.goToNewReceipt()
    }
}

extension MyReceiptsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return medicines.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
}

extension MyReceiptsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicineCell.identifier, for: indexPath) as! MedicineCell
        let medicine = medicines[indexPath.section]
        cell.configure(title: medicine.remedy, time: medicine.time, recurrence: medicine.recurrence)

        cell.onDelete = { [weak self] in
            guard let self = self else { return }

            if let actualIndexPath = tableView.indexPath(for: cell) {
                if actualIndexPath.section < self.medicines.count {
                    let medicine = self.medicines[actualIndexPath.section]

                    self.viewModel.deleteReceipt(byId: medicine.id)
                    self.viewModel.removeRemoveNotifications(for: medicine.remedy)

                    self.medicines.remove(at: actualIndexPath.section)

                    tableView.deleteSections(IndexSet(integer: actualIndexPath.section), with: .automatic)
                }
            } else {
                print("Error deleting invalid section")
            }
        }

        return cell
    }
}

#if DEBUG
import SwiftUI

struct MyReceiptsViewControllerPreview: PreviewProvider {
    private static let flowController: MedicineReminderFlowController = {
        let flowController = MedicineReminderFlowController()
        _ = flowController.startFlow()
        return flowController
    }()

    static var previews: some View {
        UIViewControllerPreview {
            MyReceiptsViewController(
                contentView: MyReceiptsView(),
                flowDelegate: flowController
            )
        }
        .ignoresSafeArea()
    }
}
#endif

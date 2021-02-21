//
//  AddAccountViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 03.02.2021.
//

import Foundation
import TableKit

protocol AddAccountModule: Presentable {
    var onFinish: ParameterClosure<Account>? { get set }
}
final class AddAccountViewController: BaseTableController<AddAccountViewModel>, AddAccountModule {

    private let builder = AddAccountBuilder()

    private var accountName: String?
    private var accountBalance: Double?

    var onFinish: ParameterClosure<Account>?

    //MARK: - Overrode

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func refreshData() {
        super.refreshData()

        fillTable()
    }

    override func localize() {
        title = .addAccountTitle
    }

    func showError(message: String) {
        let alertController = UIAlertController(title: .errorTitle,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: .okButtonTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

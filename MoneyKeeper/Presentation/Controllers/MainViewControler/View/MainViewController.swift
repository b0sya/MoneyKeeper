//
//  MainViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import Foundation
import TableKit

final class MainViewController: BaseTableController<MainViewModel> {
    private let builder = MainBuilder()

    override func buildSections() -> [TableSection] {
        builder.buildSections(from: viewModel)
    }

    override func configureTable() {
        tableDirector += buildSections()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true

        title = .mainScreenTitle
        viewModel.viewDidLoaded()
        
    }
}

//
//  MainViewModel.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 20.01.2021.
//

import Foundation

final class MainViewModel: RxViewModel {

    weak var view: MainViewController?
    
    func viewDidLoaded() {
        view?.configureTable()
    }
    
}

extension MainViewModel: MainBuilderDataSource {
    var accountsCellsViewModels: [DefaultCellViewModel] {
        [
            DefaultCellViewModel(title: "Счет 1", value: "0", icon: nil),
            DefaultCellViewModel(title: "Счет 2", value: "100", icon: nil),
        ]
    }

    var serviceCellsViewModel: [DefaultCellViewModel] {
        [
            DefaultCellViewModel(title: "Бюджеты", value: nil, icon: nil),
            DefaultCellViewModel(title: "Запланированные", value: nil, icon: nil),
            DefaultCellViewModel(title: "Планы", value: nil, icon: nil),
            DefaultCellViewModel(title: "Отчеты", value: nil, icon: nil),
            DefaultCellViewModel(title: "Настройки", value: nil, icon: nil),
        ]
    }


}

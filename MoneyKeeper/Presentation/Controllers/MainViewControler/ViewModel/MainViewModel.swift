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
    var addAccountViewModel: TappableCellViewModel {
        .init {
            print("Added")
        }
    }

    var accountsCellsViewModels: [DefaultCellViewModel] {
        [
            DefaultCellViewModel(title: "Счет 1", value: nil, icon: nil, tapAction: { 
                print("Счет 1 tapped")
            }),
            DefaultCellViewModel(title: "Счет 1", value: nil, icon: nil, tapAction: nil)
        ]
    }

    var serviceCellsViewModel: [DefaultCellViewModel] {
        []
    }


}

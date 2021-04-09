//
//  LoadableViewController.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 09.04.2021.
//

import Foundation

class LoadableViewController<View: BaseView, ViewModel>: BaseViewController<View, ViewModel> {
    let loadingIndicator = LoadingIndicator()
    
    override func configureLayout() {
        super.configureLayout()
        
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

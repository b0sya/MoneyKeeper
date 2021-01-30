//
//  BaseView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 18.01.2021.
//

import UIKit

class BaseView: UIView {
    
    required init() {
        super.init(frame: .zero)
        addSubviews()
        configureAppearance()
        configureLayout()
        localize()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        
    }
    
    func configureAppearance() {
        
    }
    
    func localize() {
        
    }
    
    func configureLayout() {

    }
    
    
}

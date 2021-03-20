//
//  TableSectionHeaderView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 19.03.2021.
//

import SnapKit
import UIKit

final class TableSectionHeader: BaseView {
    let titleLabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(titleLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(22)
            $0.bottom.equalToSuperview().offset(-7)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .backgroundGray
    }
}

extension TableSectionHeader: ConfigurableView {
    func configure(with string: String) {
        titleLabel.text = string
    }
}

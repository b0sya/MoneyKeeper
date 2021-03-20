//
//  AcountInfoCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class AccountInfoCellView: RoundedContainerCellView {
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(titleLabel)
        addSubview(valueLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
        }
        
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .MKGreen
        
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textAlignment = .center
        
        valueLabel.font = .systemFont(ofSize: 21)
        valueLabel.textAlignment = .center
    }
}

extension AccountInfoCellView: ConfigurableView {
    func configure(with viewModel: AccountInfoCellViewModel) {
        titleLabel.text = viewModel.titleLabelText
        valueLabel.text = viewModel.valueLabelText
    }
    
}

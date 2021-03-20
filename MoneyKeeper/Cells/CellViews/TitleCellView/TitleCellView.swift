//
//  TitleCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 21.02.2021.
//

import UIKit

final class TitleCellView: RoundedContainerCellView {
    let titleLabel = UILabel()
    
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(titleLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()

        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-8)
        }

    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        titleLabel.textAlignment = .left
        
    }
}

extension TitleCellView: ConfigurableView {
    func configure(with viewModel: TitleCellViewModel) {
        titleLabel.text = viewModel.title
    }
}

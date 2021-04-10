//
//  AccountCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import UIKit

class AccountCellView: DefaultCellView {
    let valueLabel = UILabel()

    override func addSubviews() {
        super.addSubviews()

        addSubview(valueLabel)
    }

    override func configureLayout() {
        super.configureLayout()

        leftStackView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualTo(valueLabel.snp.leading).offset(-8)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalTo(leftStackView)
            $0.bottom.equalTo(leftStackView)
            $0.trailing.equalToSuperview().inset(16)
        }
        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
    }
    
    override func configureLyoutWithArrow() {
        super.configureLyoutWithArrow()
        
        valueLabel.snp.remakeConstraints {
            $0.top.equalTo(leftStackView)
            $0.bottom.equalTo(leftStackView)
            $0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-8)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.top.equalTo(leftStackView).inset(4)
            $0.bottom.equalTo(leftStackView).inset(4)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(arrowImageView.snp.height)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        valueLabel.textAlignment = .right
    }

    override func configure(with viewModel: DefaultCellViewModel) {
        super.configure(with: viewModel)

        guard let viewModel = viewModel as? AccountCellViewModel else { return }

        valueLabel.attributedText = viewModel.currencyValue
    }
}

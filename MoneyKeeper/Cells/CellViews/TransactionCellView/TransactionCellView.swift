//
//  TransactionCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellView: AccountCellView {
    
    private let timeLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(timeLabel)
        addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        leftStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualTo(valueLabel.snp.leading).offset(-8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalTo(leftStackView)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    private func configureCategoryAndDescriptionLayout() {
        timeLabel.snp.remakeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalTo(leftStackView)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(timeLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        timeLabel.textColor = timeLabel.textColor.withAlphaComponent(0.3)
        
        descriptionLabel.textColor = descriptionLabel.textColor.withAlphaComponent(0.3)
        descriptionLabel.numberOfLines = 0
    }
    
    override func configure(with viewModel: DefaultCellViewModel) {
        super.configure(with: viewModel)
        
        guard let transactionCellViewModel = viewModel as? TransactionCellViewModel else {
            return
        }
        
        if let cornerMask = transactionCellViewModel.cornerMask {
            layer.maskedCorners = cornerMask
            layer.cornerRadius = 8
        } else {
            layer.cornerRadius = 0
        }
        
        timeLabel.text = transactionCellViewModel.time
        
        if let description = transactionCellViewModel.description, !description.isEmpty {
            configureCategoryAndDescriptionLayout()
            descriptionLabel.text = description
        }
    }
}

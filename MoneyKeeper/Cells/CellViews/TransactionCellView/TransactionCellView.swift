//
//  TransactionCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

class TransactionCellView: AccountCellView {
    
    private let timeLabel = UILabel()
    private let accountNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(timeLabel)
        addSubview(accountNameLabel)
        addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        leftStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualTo(valueLabel.snp.leading).offset(-8)
        }
        
        timeLabel.snp.makeConstraints{
            $0.trailing.equalTo(valueLabel)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        accountNameLabel.snp.makeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalTo(timeLabel.snp.leading).offset(-8)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
        }

        timeLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        accountNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
    }
    
    private func configureCategoryAndDescriptionLayout() {
        timeLabel.snp.remakeConstraints {
            $0.trailing.equalTo(valueLabel)
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
        timeLabel.textAlignment = .right
        
        
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
        
        if transactionCellViewModel.showAccountName {
            accountNameLabel.text =  "Счет: \(transactionCellViewModel.accountName)"
        }
        
        if let description = transactionCellViewModel.description, !description.isEmpty {
            configureCategoryAndDescriptionLayout()
            descriptionLabel.text = description
        }
    }
}

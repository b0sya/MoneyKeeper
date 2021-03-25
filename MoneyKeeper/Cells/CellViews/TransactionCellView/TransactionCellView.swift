//
//  TransactionCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 14.03.2021.
//

import UIKit

final class TransactionCellView: AccountCellView {
    
    private let categoryLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(categoryLabel)
        addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        leftStackView.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualTo(valueLabel.snp.leading).offset(-8)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalTo(leftStackView)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
    }
    
    private func configureCategoryAndDescriptionLayout() {
        categoryLabel.snp.remakeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalTo(leftStackView)
            $0.top.equalTo(leftStackView.snp.bottom).offset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(leftStackView)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        categoryLabel.textColor = categoryLabel.textColor.withAlphaComponent(0.3)
        
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
        
        categoryLabel.text = transactionCellViewModel.categoryName
        
        if let description = transactionCellViewModel.description, !description.isEmpty {
            configureCategoryAndDescriptionLayout()
            descriptionLabel.text = description
        }
    }
}

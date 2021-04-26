//
//  CategoryCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 15.04.2021.
//

import UIKit

final class CategoryCellView: RoundedContainerCellView {
    private let stackView = UIStackView()
    
    private let titleLabel = UILabel()
    private let subcategoryCountLabel = UILabel()
    private let goToSubCategoriesButton = UIButton()
    
    var onGoToSubcategoriesTap: VoidClosure?
    
    override func addSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subcategoryCountLabel)
        stackView.addArrangedSubview(goToSubCategoriesButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        goToSubCategoriesButton.snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        titleLabel.font = .systemFont(ofSize: 16)
        subcategoryCountLabel.font = .systemFont(ofSize: 14)
        
        goToSubCategoriesButton.layer.cornerRadius = 8
        goToSubCategoriesButton.setBackgroundColor(.MKGreen, for: .normal)
        goToSubCategoriesButton.setBackgroundColor(UIColor.MKGreen.withAlphaComponent(0.3), for: .disabled)
        goToSubCategoriesButton.setTitle("Перейти к подкатегориям", for: .normal)
    }
    
    override func addTargets() {
        super.addTargets()
        
        goToSubCategoriesButton.addTarget(self, action: #selector(goToSubcategoriesTapped), for: .touchUpInside)
    }
    
    @objc private func goToSubcategoriesTapped() {
        onGoToSubcategoriesTap?()
    }
}

extension CategoryCellView: ConfigurableView {
    func configure(with viewModel: CategoryCellViewModel) {
        titleLabel.text = viewModel.title
        subcategoryCountLabel.text = viewModel.subcategoryCountText
        
        guard viewModel.showSubcategoriesButton else {
            subcategoryCountLabel.isHidden = true
            goToSubCategoriesButton.isHidden = true
            return
        }
        
        subcategoryCountLabel.isHidden = viewModel.subcategoryCountText == nil
        goToSubCategoriesButton.isHidden = viewModel.subcategoryCountText == nil
        
        self.onGoToSubcategoriesTap = viewModel.onGoTuSubcategoriesTap
    }
}



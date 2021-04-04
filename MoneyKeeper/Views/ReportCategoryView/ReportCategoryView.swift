//
//  SimpleDataBubleVIew.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 25.03.2021.
//

import UIKit

final class ReportCategoryView: RoundedContainerCellView {
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    private let arrowImageView = UIImageView()
    
    private let stackView = UIStackView()
    
    var tapAction: VoidClosure?
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(stackView)
        addSubview(valueLabel)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(arrowImageView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(8)
        }
        
        valueLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(8)
            $0.top.equalTo(stackView.snp.bottom).offset(8)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.width.equalTo(10)
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        valueLabel.textColor = .MKGreen
        valueLabel.textAlignment = .right
        valueLabel.font = .boldSystemFont(ofSize: 24)
        valueLabel.minimumScaleFactor = 0.1
        valueLabel.adjustsFontSizeToFitWidth = true
        
        titleLabel.textAlignment = .right
        titleLabel.font = .systemFont(ofSize: 10)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        arrowImageView.image = .arrowRight
        arrowImageView.tintColor = .blackWhite
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.clipsToBounds = true
    }
    
    override func addTargets() {
        super.addTargets()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selfWasTapped)))
    }
    
    @objc private func selfWasTapped() {
        tapAction?()
    }
}

extension ReportCategoryView: ConfigurableView {
    func configure(with viewModel: ReportCategoryViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        
        tapAction = viewModel.tapAction
        
        arrowImageView.isHidden = viewModel.tapAction == nil
    }
}

//
//  SelectCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 06.02.2021.
//

import UIKit

final class SelectCellView: RoundedContainerCellView {
    let titleLabel = UILabel()
    let textField = UITextField()
    let arrowImageView = UIImageView(image: .arrowRight)
    
    var onTap: VoidClosure?

    override func addSubviews() {
        super.addSubviews()

        addSubview(titleLabel)
        addSubview(textField)
        addSubview(arrowImageView)
    }

    override func configureLayout() {
        super.configureLayout()

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(100)
        }

        textField.snp.remakeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.top.equalTo(titleLabel)
            $0.bottom.equalTo(titleLabel)
        }
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)

        arrowImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).inset(4)
            $0.bottom.equalTo(titleLabel).inset(4)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(arrowImageView.snp.height)
        }
    }
    
    override func addTargets() {
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(wasTapped)))
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        arrowImageView.tintColor = .blackWhite
        
        textField.isUserInteractionEnabled = false
    }
    
    @objc private func wasTapped() {
        onTap?()
    }
}

extension SelectCellView: ConfigurableView {
    func configure(with viewModel: SelectCellViewModel) {
        titleLabel.text = viewModel.title

        textField.placeholder = viewModel.placeholder

        arrowImageView.isHidden = viewModel.onTap == nil
        
        onTap = viewModel.onTap
        
        viewModel.cell = self

    }
}


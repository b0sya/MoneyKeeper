//
//  TextFieldView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import UIKit

class TextFieldCellView: RoundedContainerCellView {
    let textField = UITextField()
    let titleLabel = UILabel()

    var onTextFieldValueChanged: ParameterClosure<String?>?

    override func addSubviews() {
        super.addSubviews()

        addSubview(titleLabel)
        addSubview(textField)
    }

    override func configureLayout() {
        super.configureLayout()

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(100)
        }

        textField.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.top.equalTo(titleLabel)
            $0.bottom.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)

    }

    override func configureAppearance() {
        super.configureAppearance()

    }

    override func addTargets() {
        super.addTargets()

        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }

    @objc private func textFieldValueChanged() {
        onTextFieldValueChanged?(textField.text)
    }
}

extension TextFieldCellView: ConfigurableView {
    func configure(with viewModel: TextFieldCellViewModel) {
        titleLabel.text = viewModel.title

        textField.placeholder = viewModel.placeholder

        textField.keyboardType = viewModel.isNumericField ? .numberPad : .default

        onTextFieldValueChanged = viewModel.onTextFieldEdited
    }
}

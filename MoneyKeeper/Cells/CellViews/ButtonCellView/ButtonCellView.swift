//
//  ButtonCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 05.02.2021.
//

import Foundation
import SnapKit

final class ButtonCellView: BaseView {
    let button = UIButton()

    var onButtonTap: VoidClosure?

    override func addSubviews() {
        super.addSubviews()

        addSubview(button)
    }

    override func configureLayout() {
        super.configureLayout()

        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        button.setBackgroundColor(.MKGreen, for: .normal)
        button.setBackgroundColor(UIColor.MKGreen.withAlphaComponent(0.3), for: .disabled)
        button.layer.cornerRadius = CGFloat.buttonCornerRadius
    }

    override func addTargets() {
        super.addTargets()

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        onButtonTap?()
    }
}

extension ButtonCellView: ConfigurableView {
    func configure(with viewModel: ButtonCellViewModel) {
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.isEnabled = viewModel.isEnabled

        onButtonTap = viewModel.buttonAction
        
        viewModel.view = self
    }
}

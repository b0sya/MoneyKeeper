//
//  AddAccountView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import UIKit
import SnapKit

final class AddAccountView: BaseView {
    private let addIconImageView = UIImageView()

    override func addSubviews() {
        super.addSubviews()

        addSubview(addIconImageView)
    }

    override func configureLayout() {
        addIconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(15)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        addIconImageView.image = .addIcon
        addIconImageView.contentMode = .scaleAspectFit

        backgroundColor = .white
        layer.cornerRadius = 14
    }
}

extension AddAccountView: ConfigurableView {
    func configure(with viewModel: TappableCellViewModel) {
        
    }
}

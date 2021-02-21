//
//  AddAccountView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 30.01.2021.
//

import UIKit
import SnapKit

final class CenterIconCellView: RoundedContainerCellView {
    private let addIconImageView = UIImageView()

    override func addSubviews() {
        super.addSubviews()

        addSubview(addIconImageView)
    }

    override func configureLayout() {
        super.configureLayout()

        addIconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(CGFloat.smallIconSize)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        addIconImageView.image = .addIcon
        addIconImageView.contentMode = .scaleAspectFit
    }
}

extension CenterIconCellView: ConfigurableView {
    func configure(with viewModel: TappableCellViewModel) {
        
    }
}

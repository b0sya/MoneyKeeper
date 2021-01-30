//
//  DefaultCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import UIKit
import TableKit

final class DefaultCellView: BaseView {
    private let contentView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let arrowImageView = UIImageView()

    override func addSubviews() {
        super.addSubviews()

        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(arrowImageView)
    }

    override func configureLayout() {
        super.configureLayout()

        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel)
            $0.bottom.equalTo(titleLabel)
            $0.width.equalTo(25)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        valueLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }

        arrowImageView.snp.makeConstraints {
            $0.leading.equalTo(valueLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(10)
            $0.height.equalTo(15)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        backgroundColor = .white
        layer.cornerRadius = 14

        titleLabel.textAlignment = .left
        valueLabel.textAlignment = .right

        arrowImageView.image = .arrowRight
        arrowImageView.contentMode = .scaleAspectFit

    }
}

extension DefaultCellView: ConfigurableView {
    func configure(with viewModel: DefaultCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
        iconImageView.image = viewModel.icon

        arrowImageView.isHidden = viewModel.onTap == nil
    }
}

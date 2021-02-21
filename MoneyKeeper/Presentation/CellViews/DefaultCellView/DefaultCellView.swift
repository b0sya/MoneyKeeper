//
//  DefaultCellView.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 24.01.2021.
//

import UIKit
import TableKit

class DefaultCellView: RoundedContainerCellView, ConfigurableView {
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let arrowImageView = UIImageView()

    let leftStackView = UIStackView()

    override func addSubviews() {
        super.addSubviews()

        addSubview(leftStackView)
        addSubview(arrowImageView)

        leftStackView.addArrangedSubview(iconImageView)
        leftStackView.addArrangedSubview(titleLabel)
    }

    override func configureLayout() {
        super.configureLayout()


        iconImageView.snp.makeConstraints {
            $0.width.equalTo(iconImageView.snp.height).offset(10).priority(500)
        }

        leftStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-8)
        }

        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)

        arrowImageView.snp.makeConstraints {
            $0.top.equalTo(leftStackView).inset(4)
            $0.bottom.equalTo(leftStackView).inset(4)
            $0.trailing.equalToSuperview().inset(8)
            $0.width.equalTo(arrowImageView.snp.height)
        }

    }

    override func configureAppearance() {
        super.configureAppearance()

        titleLabel.textAlignment = .left

        arrowImageView.image = .arrowRight
        arrowImageView.contentMode = .scaleAspectFit

        iconImageView.contentMode = .scaleAspectFit

        leftStackView.distribution = .fill
        leftStackView.spacing = 4

    }

    func configure(with viewModel: DefaultCellViewModel) {
        titleLabel.text = viewModel.title
        iconImageView.image = viewModel.icon

        iconImageView.isHidden = viewModel.icon == nil

        arrowImageView.isHidden = viewModel.onTap == nil
    }
}

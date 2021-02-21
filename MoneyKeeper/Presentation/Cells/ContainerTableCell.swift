//
//  DefaultContainerCell.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import UIKit
import TableKit

class ContainerTableCell<View: UIView>: BaseTableViewCell,
                                        ConfigurableCell where View: ConfigurableView {

    let view = View()

   var contentViewBackgroundColor: UIColor {
        .clear
    }

    var contentInsets: UIEdgeInsets {
        .zero
    }

    func configure(with viewModel: View.ViewModelType) {
        view.configure(with: viewModel)
    }

    override func addViews() {
        super.addViews()

        contentView.addSubview(view)
    }

    override func configureLayout() {
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(contentInsets)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .clear

        contentView.backgroundColor = contentViewBackgroundColor
    }
}

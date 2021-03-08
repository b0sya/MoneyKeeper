//
//  BaseTableCell.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import UIKit

public class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addViews()
        bindViews()
        configureLayout()
        configureAppearance()
        localize()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func addViews() {}

    func bindViews() {}

    func configureLayout() {}

    func configureAppearance() {
        selectionStyle = .none
    }

    func localize() {}
}


//
//  BaseViewController.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 17.01.2021.
//

import UIKit

class BaseViewController<View: BaseView, ViewModel>: UIViewController {
    private(set) var baseView = View()
    let viewModel: ViewModel


    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        configureAppearance()
        localize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = baseView
    }
    
    func configureLayout() {
        
    }

    func configureAppearance() {

    }

    func localize() {

    }
    
	func showError(message: String) {
		let alertController = UIAlertController(title: .error,
												message: message,
												preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: .okButtonTitle, style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
}

//
//  ReportCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

extension CoordinatorFactory {
    func makeReportCoordinator(router: Router) -> ReportCoordinator {
        ReportCoordinator(router: router,
                          factory: moduleFactory,
                          coordinatorFactory: self)
    }
}

final class ReportCoordinator: BaseCoordinator {
    typealias ReportCoordinatorModuleFactory = ReportModuleFactory & CategoryReportModuleFactory
    
    private let factory: ReportCoordinatorModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    
    init(router: Router,
         factory: ReportCoordinatorModuleFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showReport()
    }
    
    private func showReport() {
        let module = factory.makeReportModule()
        
        module.onCostCategoryTap = { [weak self] in
            self?.showCategoryReport(transactions: $0)
        }
        
        router.push(module)
    }
    
    private func showCategoryReport(transactions: [FTransaction]) {
        let module = factory.makeCategoryReportModule(for: transactions)
        
        router.push(module)
    }
}

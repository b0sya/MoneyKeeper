//
//  ReportCoordinator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 28.03.2021.
//

extension CoordinatorFactory {
    func makeReportCoordinator(router: Router, currentBalance: Double) -> ReportCoordinator {
        ReportCoordinator(router: router,
                          factory: moduleFactory,
                          coordinatorFactory: self,
                          currentBalance: currentBalance)
    }
}

final class ReportCoordinator: BaseCoordinator {
    typealias ReportCoordinatorModuleFactory = ReportModuleFactory & DetailedReportModuleFactory
    
    private let factory: ReportCoordinatorModuleFactory
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let currentBalance: Double
    
    init(router: Router,
         factory: ReportCoordinatorModuleFactory,
         coordinatorFactory: CoordinatorFactory,
         currentBalance: Double) {
        self.router = router
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.currentBalance = currentBalance
    }
    
    override func start() {
        showReport(currentBalance: currentBalance)
    }
    
    private func showReport(currentBalance: Double) {
        let module = factory.makeReportModule(currentBalance: currentBalance)
        
        module.onDetailderItemTap = { [weak self] in
            self?.showCategoryReport(transactions: $0.transactions, totalValue: $0.totalValue)
        }
        
        router.push(module)
    }
    
    private func showCategoryReport(transactions: [FTransaction], totalValue: Double) {
        let module = factory.makeDetailedReportModule(for: transactions, totalValue: totalValue)
        
        router.push(module)
    }
}

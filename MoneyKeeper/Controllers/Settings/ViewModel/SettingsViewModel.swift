import FirebaseAuth

final class SettingsViewModel {
    weak var view: SettingsModuleInput?
    
    func logout() {
        GoogleAuth.logOut { [weak self] in
            UserDefaults.standard.removeObject(forKey: Keys.userId)
            self?.view?.onLoggedOut?()
        } failureCompletion: { [weak self] error in
            self?.view?.showError(message: error.localizedDescription)
        }

    }
}

//
//  RestoreWalletNavigator.swift
//  Zupreme
//
//  Created by Alexander Cyon on 2018-09-08.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import UIKit
import Zesame

final class RestoreWalletCoordinator: AbstractCoordinator<RestoreWalletCoordinator.Step> {
    enum Step {
        case didRestore(wallet: Wallet)
    }

    private let useCase: ChooseWalletUseCase

    init(navigationController: UINavigationController, useCase: ChooseWalletUseCase) {
        self.useCase = useCase
        super.init(navigationController: navigationController)
    }

    override func start() {
        toRestoreWallet()
    }
}

// MARK: - Private
private extension RestoreWalletCoordinator {

    func toMain(restoredWallet: Wallet) {
        stepper.step(.didRestore(wallet: restoredWallet))
    }

    func toRestoreWallet() {
        present(type: RestoreWallet.self, viewModel: RestoreWalletViewModel(useCase: useCase)) { [weak self] in
            switch $0 {
            case .didRestore(let wallet): self?.toMain(restoredWallet: wallet)
            }
        }
    }
}

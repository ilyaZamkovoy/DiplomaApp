//
//  DetectModuleAssemble.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 22/05/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation

class DetectModuleAssemble: DetectModuleAssembleInput {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let viewController = viewInput as? DetectModuleVIew {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: DetectModuleVIew) {
        
        let router = DetectModuleRouter()
        router.view = viewController
        
        let presenter = DetectModulePresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = DetectModuleInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
    }

}

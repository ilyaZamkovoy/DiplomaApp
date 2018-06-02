//
//  DetectModulePresenter.swift
//  DiplomaApp
//
//  Created by Zamkovoy Ilya on 22/05/2018.
//  Copyright © 2018 Zamkovoy Ilya. All rights reserved.
//

import Foundation

class DetectModulePresenter: DetectModulePresenterInput, DetectModuleVIewOutput, DetectModuleInteractorOutput {
    
    weak var view: DetectModuleVIewInput?
    var interactor: DetectModuleInteractorInput!
    var router: DetectModuleRouterInput!
}

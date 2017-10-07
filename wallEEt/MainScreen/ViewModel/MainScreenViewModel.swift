//
//  MainScreenViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import Charts
import RxSwift
import RealmSwift

protocol MainScreenViewModelType {
    var coordinatorDelegate:MainScreenViewModelCoordinatorDelegate?{get set}
    func nextView()
}

protocol MainScreenViewModelCoordinatorDelegate: class
{
    func mainScreenViewModelDidTapNext()
}

final class MainScreenViewModel:MainScreenViewModelType{
    weak var coordinatorDelegate:MainScreenViewModelCoordinatorDelegate?
    //MARK:Input
    
    
    func nextView() {
        coordinatorDelegate?.mainScreenViewModelDidTapNext()
    }
    
    //MARK:Output
    var account:AccountModel
    //MARK:Init
    init(coordinatorDelegate:MainScreenViewModelCoordinatorDelegate?,accountModel:AccountModel){
        self.coordinatorDelegate = coordinatorDelegate
        self.account = accountModel
    }
    
}



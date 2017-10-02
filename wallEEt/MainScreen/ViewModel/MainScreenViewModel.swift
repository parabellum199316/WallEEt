//
//  MainScreenViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
protocol MainScreenViewModelType {
    var stringToShow:String{get set}
    var coordinatorDelegate:MainScreenViewModelCoordinatorDelegate?{get set}
    func nextView()
}

protocol MainScreenViewModelCoordinatorDelegate: class
{
    func mainScreenViewModelDidTapNext()
}

final class MainScreenViewModel:MainScreenViewModelType{
   
     weak var coordinatorDelegate:MainScreenViewModelCoordinatorDelegate?
   
    var stringToShow:String
    init(){
        stringToShow = "TEST FROM VM"
    }
    func nextView() {
        coordinatorDelegate?.mainScreenViewModelDidTapNext()
    }
}

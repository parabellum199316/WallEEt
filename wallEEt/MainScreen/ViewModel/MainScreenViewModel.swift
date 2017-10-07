//
//  MainScreenViewModel.swift
//  wallEEt
//
//  Created by ParaBellum on 10/1/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import RxSwift



struct MainScreenViewModel{
    let title:Observable<String>
    let showDetails:AnyObserver<Void>
    let showDetailsScreen:Observable<Void>
    init(testText:String){
        let _currentLanguage = BehaviorSubject<String>(value: testText)
        self.title = _currentLanguage.asObservable().map{"\($0)"}
        let _showDetails =  PublishSubject<Void>()
        self.showDetails = _showDetails.asObserver()
        self.showDetailsScreen = _showDetails.asObservable()
    }
    

    
}



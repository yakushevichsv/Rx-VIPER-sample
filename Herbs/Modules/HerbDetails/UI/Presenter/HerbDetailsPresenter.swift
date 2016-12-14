//
//  HerbDetailsPresenter.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift

//MARK: -  HerbDetailsModuleInterface
protocol HerbDetailsModuleInterface {
    func displayDetails()
    func cancelDisplay()
    func hide()
}

//MARK: - HerbDetailsPresenter
final class HerbDetailsPresenter {
    let interactor: HerbDetailsInteractorProtocol
    let router: HerbDetailsWireframeProtocol
    let disposeBag = DisposeBag()
    
    var operation: Disposable! = nil
    var wrapper: HerbsAndHealthProblemWrapper! = nil
    
    weak var vc: HerbDetailsViewProtocol! = nil
    
    init(interactor: HerbDetailsInteractorProtocol, wireframe router: HerbDetailsWireframeProtocol,
         view vc: HerbDetailsViewProtocol) {
        
        self.router = router
        self.interactor = interactor
        self.vc = vc
    }
}

//MARK: - HerbDetailsModuleInterface's implementation
extension HerbDetailsPresenter: HerbDetailsModuleInterface {
    func hide() {
        cancelDisplay()
        self.vc.dismiss()
    }
    
    func cancelDisplay() {
        if let op = operation {
            operation = nil
            op.dispose()
        }
    }
    
    func displayDetails() {
        let result = self.interactor.getHerbDetails(herbWrapper: wrapper)
        self.vc.displayLoadingProgress()
        operation = result.subscribeOn(MainScheduler.instance).subscribe {[unowned self] (event) in
            switch event {
            case .next(let herb):
                self.vc.didReceiveDetailsInfo(wrapper: herb)
                break
            case .completed:
                self.operation = nil
                self.vc.hideLoadingProgress()
                break
            case .error(let error):
                self.operation = nil
                self.vc.hideLoadingProgress()
                self.vc.present(error: error)
                break
            }
        }
        disposeBag.insert(operation)
    }
}

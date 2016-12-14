//
//  HerbsGalleryPresenter.swift
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift

//MARK: -  HerbsGalleryModuleInterface
protocol HerbsGalleryModuleInterface {
    func displayHerbs()
    func didSelectItemAtIndex(index: Int)
    func prepareForDisplay(destination view:Any)
    var itemsSequence: Observable<[HerbsAndHealthProblemWrapper]> {get}
    var isEmpty: Observable<Bool> {get}
}

//MARK: - HerbsGalleryPresenter
final class HerbsGalleryPresenter {
    let interactor: HerbsGalleryInteractorProtocol
    let router: HerbsGalleryWireframeProtocol
    let itemsSequenceInner = Variable<[HerbsAndHealthProblemWrapper]>([])
    let isEmptySequence = Variable<Bool>(true)
    
    weak var vc: HerbsGalleryViewProtocol! = nil
    
    let disposeBag = DisposeBag()
    var activeHerb: HerbsAndHealthProblemWrapper? = nil {
        didSet {
            isEmptySequence.value = activeHerb == nil
        }
    }
    
    init(interactor: HerbsGalleryInteractorProtocol, wireframe router: HerbsGalleryWireframeProtocol,
         view vc: HerbsGalleryViewProtocol) {
        
        self.router = router
        self.interactor = interactor
        self.vc = vc
    }
}

//MARK: - HerbsGalleryModuleInterface's implementation
extension HerbsGalleryPresenter: HerbsGalleryModuleInterface {
    func prepareForDisplay(destination view:Any) {
        guard let detailsModule = view as? HerbDetailsViewProtocol else {
            assert(false)
            return
        }
        router.prepareToDisplayItem(item: detailsModule, herbWrapper: activeHerb!)
    }
    
    func didSelectItemAtIndex(index: Int) {
        let herbWrapper = itemsSequenceInner.value[index]
        activeHerb = herbWrapper
        vc.needToUpdateHerbImage(data: herbWrapper.data)
        let text = "Herb \(herbWrapper.herb.herbName) queres disease \(herbWrapper.herb.healthProblemName)"
        vc.needToUpdateHerbDescription(text:text)
    }

    var isEmpty: Observable<Bool> {
        return isEmptySequence.asObservable()
    }
    
    var itemsSequence: Observable<[HerbsAndHealthProblemWrapper]> {
        return itemsSequenceInner.asObservable()
    }
    
    func displayHerbs() {
        let result = self.interactor.getAllHerbs()
        self.vc.displayLoadingProgress()
        result.subscribeOn(MainScheduler.instance).subscribe {[unowned self] (event) in
            switch event {
            case .next(let herbs):
                self.vc.didReceiveItems(items: [herbs])
                self.itemsSequenceInner.value += [herbs]
                break
            case .completed:
                self.vc.hideLoadingProgress()
                if self.itemsSequenceInner.value.count != 0 {
                    self.didSelectItemAtIndex(index: 0)
                }
                break
            case .error(let error):
                self.vc.hideLoadingProgress()
                self.vc.present(error: error)
                break
            }
        }.addDisposableTo(disposeBag)
    }
}

//
//  ImageAccesor
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/13/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import Foundation
import RxSwift

//MARK: - HerbsAndHealthProblemWrapper
struct HerbsAndHealthProblemWrapper {
    let herb: HerbsAndHealthProblem
    let data: Data
}

typealias HerbsAndHealthProblemWrapperSequence = Observable<HerbsAndHealthProblemWrapper>

//MARK: - ImageAccesorProtocol Protocol
protocol ImageAccesorProtocol {
    func receiveImage(herbPtr: HerbsAndHealthProblem?) -> HerbsAndHealthProblemWrapperSequence
}

//MARK: - ImageAccessor 
final class ImageAccessor {
    let imagesCount = 5
    
    fileprivate func getImageData(herb: HerbsAndHealthProblem) -> Data {
        let reminder = herb.hashValue % imagesCount
        var name: String! = nil
        
        switch reminder {
        case 0:
            name = "anise"
            break
        case 1:
            name = "basil"
            break
        case 2:
            name =  "anise"//"marjorana"
            break
        case 3:
            name = "anise" //"rosemary"
            break
        default:
            name = "basil"// "saffron"
            break
        }
        assert(!name.isEmpty)
        
        return NSDataAsset(name: name)!.data
    }
}

//MARK: - ImageAccessorProtocol's implementation
extension ImageAccessor:  ImageAccesorProtocol {
    internal func receiveImage(herbPtr: HerbsAndHealthProblem?) -> HerbsAndHealthProblemWrapperSequence {
        guard let herb = herbPtr else {
            return Observable<HerbsAndHealthProblemWrapper>.empty()
        }
        
        let wrapper = HerbsAndHealthProblemWrapper(herb: herb, data: getImageData(herb: herb))
        
        return Observable<HerbsAndHealthProblemWrapper>.just(wrapper)
    }
}

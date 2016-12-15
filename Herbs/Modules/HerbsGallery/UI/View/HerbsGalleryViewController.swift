//
//  HerbsGalleryViewController
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

//MARK: - HerbsGalleryViewProtocol
protocol HerbsGalleryViewProtocol: UICommuncationProtocol {
    func didReceiveItems(items: [HerbsAndHealthProblemWrapper])
    func needToUpdateHerbImage(data: Data)
    func needToUpdateHerbDescription(text: String)
}

//MARK: - HerbsGalleryViewController
final class HerbsGalleryViewController: UIViewController {
    
    @IBOutlet weak var herbImage: UIImageView!
    @IBOutlet weak var herbDescription: UITextView!
    @IBOutlet weak var cvHerbs: UICollectionView!
    @IBOutlet weak var btnHerbDetails: UIButton!
    
    let disposeBag = DisposeBag()
    
    var presenter: HerbsGalleryModuleInterface! = nil {
        didSet {
            configure()
        }
    }
    
    func configure() {
        guard presenter != nil && isViewLoaded else { return }
        
        presenter.displayHerbs()
        prepareCollection()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func prepareCollection() {
        
        presenter.itemsSequence.bindTo(cvHerbs.rx.items(cellIdentifier: "Cell", cellType: CollectionViewCell.self)) { (row, element, cell) in
            cell.ivHerb.image = element.data.toImage()
            }
            .addDisposableTo(disposeBag)
        
        presenter.isEmpty.map{!$0}.bindTo(btnHerbDetails.rx.isEnabled).addDisposableTo(disposeBag)
        
        cvHerbs.rx.itemSelected.asObservable().subscribe(onNext: { (index) in
            self.presenter.didSelectItemAtIndex(index: index.row)
        }).addDisposableTo(disposeBag)
    }
    
    @IBAction func displayHerbDetails(sender: UIButton) {
        self.performSegue(withIdentifier: "herbDetailsSegueId", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "herbDetailsSegueId" else  {
            super.prepare(for: segue, sender: sender)
            return
        }
        
        let wFrame  = herbImage.superview!.convert(herbImage.frame, to: nil)
        
        
        presenter.prepareForDisplay(destination: segue.destination,initialFrame: wFrame)
    }
}

//MARK: - HerbsGalleryViewProtocol's implementation
extension HerbsGalleryViewController: HerbsGalleryViewProtocol {
    func displayLoadingProgress() {
        cvHerbs.displayActivityIndicator()
        herbImage.displayActivityIndicator()
    }

    func hideLoadingProgress() {
        cvHerbs.hideActivityIndicator()
        herbImage.hideActivityIndicator()
    }

    func needToUpdateHerbImage(data: Data) {
        self.herbImage.image = data.toImage()
    }
    
    func needToUpdateHerbDescription(text: String) {
        self.herbDescription.text = text
    }
    
    func didReceiveItems(items: [HerbsAndHealthProblemWrapper]) {
        debugPrint(#function)
    }
}

//
//  HerbDetailsViewController
//  Herbs
//
//  Created by Siarhei Yakushevich on 12/12/16.
//  Copyright © 2016 Siarhei Yakushevich. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

//MARK: - HerbDetailsViewProtocol
protocol HerbDetailsViewProtocol: class, UICommuncationProtocol {
    func hideLabels()
    func displayLabels()
    func didReceiveDetailsInfo(wrapper: HerbsAndHealthProblemWrapper)
}

//MARK: - HerbDetailsViewController
final class HerbDetailsViewController: UIViewController {
    
    @IBOutlet weak var herbImage: UIImageView!
    @IBOutlet weak var lblHerbName: UILabel!
    @IBOutlet weak var lblHerbDescription: UILabel!
    @IBOutlet weak var lblCreatedTime: UILabel!
    @IBOutlet weak var lblUpdatedTime: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    let disposeBag = DisposeBag()
    var presenter: HerbDetailsModuleInterface! = nil {
        didSet {
            configure()
        }
    }
    
    func configure() {
        guard presenter != nil && isViewLoaded else { return }
        presenter.displayDetails()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func close(sender: UIButton) {
        self.presenter.hide()
    }
}

//MARK: - HerbDetailsViewProtocol's implementation
extension HerbDetailsViewController: HerbDetailsViewProtocol {
    func displayLoadingProgress() {
        herbImage.displayActivityIndicator()
    }
    
    func hideLoadingProgress() {
        herbImage.hideActivityIndicator()
    }

    
    func hideLabels() {
        change(labelsAlpha: 0.0)
        btnClose.isHidden = true
        
    }
    
    func displayLabels() {
        change(labelsAlpha: 1.0)
        btnClose.isHidden = false
    }
    
    private func change(labelsAlpha alpha: CGFloat) {
        [lblHerbName, lblCreatedTime,lblUpdatedTime,lblHerbDescription].forEach{
            $0?.alpha = alpha
        }
    }
    
    internal func didReceiveDetailsInfo(wrapper: HerbsAndHealthProblemWrapper) {
        debugPrint(#function)
        
        herbImage.image = wrapper.data.toImage()
        lblHerbName.text = wrapper.herb.herbName
        lblHerbDescription.text = wrapper.herb.healthProblemName
        lblCreatedTime.text = wrapper.herb.createdAt?.shortDescription() ?? String.empty
        lblUpdatedTime.text = wrapper.herb.updatedAt?.shortDescription() ?? String.empty
    }
}

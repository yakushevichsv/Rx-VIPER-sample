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
protocol HerbDetailsViewProtocol: class {
    func displayLoadingProgress()
    func hideLoadingProgress()
    func didReceiveDetailsInfo(wrapper: HerbsAndHealthProblemWrapper)
    func present(error: Error)
    func dismiss()
}

//MARK: - HerbDetailsViewController
final class HerbDetailsViewController: UIViewController {
    
    @IBOutlet weak var herbImage: UIImageView!
    @IBOutlet weak var lblHerbName: UILabel!
    @IBOutlet weak var lblHerbDescription: UILabel!
    @IBOutlet weak var lblCreatedTime: UILabel!
    @IBOutlet weak var lblUpdatedTime: UILabel!
    
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
    internal func didReceiveDetailsInfo(wrapper: HerbsAndHealthProblemWrapper) {
        debugPrint(#function)
        herbImage.image = wrapper.data.toImage()
        lblHerbName.text = wrapper.herb.herbName
        lblHerbDescription.text = wrapper.herb.healthProblemName
        lblCreatedTime.text = wrapper.herb.createdAt?.description ?? String.empty
        lblUpdatedTime.text = wrapper.herb.updatedAt?.description ?? String.empty
    }
    
    func dismiss() {
        if let pVC = self.presentingViewController {
            pVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func present(error: Error)  {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {(_) in
            self.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    func displayLoadingProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        debugPrint(#function)
    }
    
    func hideLoadingProgress() {
        debugPrint(#function)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

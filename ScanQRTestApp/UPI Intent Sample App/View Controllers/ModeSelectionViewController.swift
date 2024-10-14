//
//  ModeSelectionViewController.swift
//  UPI Intent Sample App
//
//  Created by Vishrut tewatia on 07/10/24.
//

import UIKit

class ModeSelectionViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet weak var intentSampleAppBtn: UIButton!
    
    //MARK: Constants
    
    var extSerialNo: String = ""
    var amount: String = ""
    var url: String = ""
    var isDeeplinkForIntentApp: Bool? = false
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let isDeeplinkForIntentApp = isDeeplinkForIntentApp, isDeeplinkForIntentApp {
            intentSampleAppBtn.sendActions(for: .touchUpInside)
        }
    }
    
    //MARK: IBAction Outlets

    @IBAction func intentSampleAppBtn(_ sender: Any) {
        if let intentSampleAppVC = UIStoryboard(name: "Main", bundle: Bundle(for: IntentSampleAppViewController.self)).instantiateViewController(withIdentifier: String(describing: IntentSampleAppViewController.self)) as? IntentSampleAppViewController {
            intentSampleAppVC.handleDeepLinkParams(extSerialNo: extSerialNo, url: url, amount: amount)
            intentSampleAppVC.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(intentSampleAppVC, animated: true)
        }
    }
    
    @IBAction func mstageQrAppBtn(_ sender: Any) {
        if let qrScannerVC = UIStoryboard(name: "Main", bundle: Bundle(for: QRScannerViewController.self)).instantiateViewController(withIdentifier: String(describing: QRScannerViewController.self)) as? QRScannerViewController {
            qrScannerVC.modalPresentationStyle = .overCurrentContext
            self.navigationController?.pushViewController(qrScannerVC, animated: true)
        }
    }

}

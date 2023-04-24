//
//  ViewController.swift
//  my-idfv-by-appsflyer
//
//  Created by Moris Gateno on 24/04/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var idfvLabel: UILabel!
    @IBOutlet weak var idfvView: UIView!
    @IBOutlet weak var shareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
        
        idfvView.layer.masksToBounds = true
        idfvView.layer.cornerRadius = 7.0
        
        displayIDFV()
        
        self.shareButton.tintColor = UIColor(red: 59/255, green: 67/255, blue: 77/255, alpha: 1)
        self.shareButton.layer.masksToBounds = true
        self.shareButton.layer.cornerRadius = 15.0
    }

    @IBAction func shareButtonClicked(_ sender: Any) {
        let dataToShare = self.idfvLabel.text
        let vc = UIActivityViewController(activityItems: [dataToShare], applicationActivities: [])
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = vc.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popoverController.sourceView = self.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }
        }
        vc.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            guard completed else { return }
        }
        vc.setValue(NSLocalizedString("AppsFlyer device info", comment: "share_email_subject"), forKey: "Subject")
        DispatchQueue.main.async { [weak self] in
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    func displayIDFV(){
        self.idfvLabel.text = UIDevice.current.identifierForVendor?.uuidString ?? "No IDFV"
        self.idfvLabel.sizeToFit()
    }
}


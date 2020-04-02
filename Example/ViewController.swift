//
//  ViewController.swift
//  Example
//
//  Created by Ilia Aparin on 01.04.2020.
//  Copyright © 2020 Clockwork, LLC. All rights reserved.
//

import UIKit
import CWRateKit

class ViewController: UIViewController {
    
    private let rateViewController = CWRateKitViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        rateViewController.delegate = self
        rateViewController.modalPresentationStyle = .overFullScreen
        
        rateViewController.confirmRateEnabled = true
        
        rateViewController.showHeaderImage = true
        rateViewController.headerImage = UIImage(named: "initial_smile")
        rateViewController.headerImageIsStatic = false
        rateViewController.headerImages = [
            UIImage(named: "smile_1"),
            UIImage(named: "smile_2"),
            UIImage(named: "smile_3"),
            UIImage(named: "smile_4"),
            UIImage(named: "smile_5")
        ]
        
        rateViewController.submitTextColor = .orange
        rateViewController.submitText = "Send Rate"
    }

    @IBAction func openRateView(_ sender: Any) {
        present(rateViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: CWRateKitViewControllerDelegate {

    func didChange(rate: Int) {
        print("Current rate is \(rate)")
    }

    func didSubmit(rate: Int) {
        print("Submit with rate \(rate)")
    }
    
    func didDismiss() {
        print("Dismiss the rate view")
    }
    
}

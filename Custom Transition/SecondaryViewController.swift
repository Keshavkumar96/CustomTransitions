//
//  SecondaryViewController.swift
//  Custom Transition
//
//  Created by Keshav on 30/12/21.
//

import UIKit

class SecondaryViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
  

}

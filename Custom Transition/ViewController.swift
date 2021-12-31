//
//  ViewController.swift
//  Custom Transition
//
//  Created by Keshav on 30/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    
    var transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destinationVC = segue.destination as? SecondaryViewController {
            destinationVC.transitioningDelegate = self
            destinationVC.modalPresentationStyle = .custom
        }
    }
    
    func getTransition(mode: TransitionState) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = mode
        transition.startingPoint = menuButton.center
        transition.circle.backgroundColor = menuButton.backgroundColor
        return transition
    }

}


extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return getTransition(mode: .presented)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return getTransition(mode: .dismissed)
    }
}

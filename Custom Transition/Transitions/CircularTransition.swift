//
//  CircularTransition.swift
//  Custom Transition
//
//  Created by Keshav on 30/12/21.
//

import UIKit

enum TransitionState {
    case presented
    case dismissed
}

class CircularTransition: NSObject {
   
    /// Animation Duration
    var duration = 0.5
    
    /// Circle Object - Will be used as animation object
    var circle = UIView()
    
    /// Indicates the starting point of the animation
    var startingPoint: CGPoint = .zero {
        didSet {
            circle.center = startingPoint
        }
    }

    var transitionMode: TransitionState = .presented

}

extension CircularTransition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionMode {
        case .presented:
            let containerView = transitionContext.containerView
            
            if let presentedView = transitionContext.view(forKey: .to) {
                let viewSize = presentedView.frame.size
                let viewCenter = presentedView.center
                
                circle = UIView()
                circle.frame = getFrameForCircle(viewSize: viewSize, viewCenter: viewCenter, startPoint: startingPoint)
                circle.center = startingPoint
                circle.backgroundColor = presentedView.backgroundColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = .identity
                    presentedView.transform = .identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                }, completion: { (success: Bool) in
                    transitionContext.completeTransition(success)
                })
                
            }
            
        case .dismissed:
    
            if let dismissingView = transitionContext.view(forKey: .from) {
                let viewCenter = dismissingView.center
                circle.layer.cornerRadius = circle.frame.self.width / 2
                circle.center = startingPoint
                
                dismissingView.center = startingPoint
                dismissingView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                dismissingView.alpha = 0
                
                UIView.animate(withDuration: duration) {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    dismissingView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    dismissingView.alpha = 1
                    dismissingView.center = viewCenter
                    
                } completion: { success in
                    dismissingView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                }

            }
            
        }
    }
    
    func getFrameForCircle(viewSize: CGSize, viewCenter: CGPoint, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)

        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}

//
//  AlertLoader.swift
//  MVVMProtocolOriented
//
//  Created by Rajagopal Ganesan on 03/07/22.
//

import UIKit

class AlertLoader {
    
    private var alertController: UIAlertController? = nil
    
    static let shared = AlertLoader()
    
    init(){}

    
    func showAlert(viewController: UIViewController) {
        
        let height: NSLayoutConstraint!
        alertController = UIAlertController(title: "Loading", message: nil, preferredStyle: .alert)
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        guard let loadingAlertController = alertController else {
            return
        }
        
        loadingAlertController.view.addSubview(activityIndicator)
            
        let xConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerY, multiplier: 1.4, constant: 0)
            
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        if let alertControllerView = loadingAlertController.view {
                
            height = NSLayoutConstraint(item: alertControllerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
           loadingAlertController.view.addConstraint(height)
        }

        DispatchQueue.main.async { [weak viewController] in
            viewController?.present(loadingAlertController, animated: true, completion: nil)
        }
    }
    
    func hideAlert() {
        
        guard let loadingAlertController = alertController else {
            return
        }
        DispatchQueue.main.async {
            loadingAlertController.dismiss(animated: true)
        }
    }
}

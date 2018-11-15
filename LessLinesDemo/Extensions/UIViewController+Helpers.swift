//
//  UIViewController+Helpers.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(contentViewController: UIViewController, toContainerView: UIView) {
        addChild(contentViewController)
        toContainerView.addSubview(contentViewController.view)
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentViewController.view.constrainEdges(toMarginOf: toContainerView)
        contentViewController.didMove(toParent: self)
    }
    
    func remove(contentViewController: UIViewController) {
        contentViewController.willMove(toParent: nil)
        contentViewController.view.removeFromSuperview()
        contentViewController.removeFromParent()
    }
    
    func showStandardQuestionAlert(question: String, action: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async { [unowned self] in
            let yesAlertAction: UIAlertAction = UIAlertAction(title: String.yes, style: .destructive, handler: action)
            let alertController = UIAlertController(title: nil, message: question, preferredStyle: .alert)
            alertController.addAction(yesAlertAction)
            alertController.addAction(UIAlertAction(title: String.no, style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showStandardForceAlert(question: String, action: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async { [unowned self] in
            let yesAlertAction: UIAlertAction = UIAlertAction(title: String.okay, style: .default, handler: action)
            let alertController = UIAlertController(title: nil, message: question, preferredStyle: .alert)
            alertController.addAction(yesAlertAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showStandardMessageAlert(_ message: String, title: String = "") {
        UIApplication.getTopMostViewController()?.showStandardMessageAlert(message, title: title)
    }
    
    func showStandardMessageAlert(_ message: String, title: String = "") {
        let alertController = UIAlertController(title: (title != "") ? title : nil, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: String.okay, style: .default, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }

}


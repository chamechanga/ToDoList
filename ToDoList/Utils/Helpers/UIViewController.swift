//
//  UIViewController.swift
//  ToDoList
//
//  Created by Indra on 3/17/23.
//

import UIKit

extension UIViewController {
    func showProgress(title: String = "Loading...") {
        ProgressHUD.show(title, interaction: false)
    }
    
    func hideProgress() {
        ProgressHUD.dismiss()
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

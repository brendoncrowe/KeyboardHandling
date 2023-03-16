//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Brendon Crowe on 3/15/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pursuitLogoYConstraint: NSLayoutConstraint!
    
    private var keyboardIsVisible = false
    private var originalYConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        textFieldDelegates()
        pulsateLogo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisteredForKeyboardNotifications()
    }
    
    private func textFieldDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func registerForKeyboardNotifications() {
        // 1. register the type of notification, i.e notifications for the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisteredForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        // 2. code that will be executed when the keyboard appears
        
        // to get the correct key, print(notification.userInfo)
        
        // UIKeyboardFrameBeginUserInfoKey NSRect: {{0(x), 852(y)}, {393(w), 336(h)}}
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        // TODO: More code
        resetUI()
    }
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalYConstraint = pursuitLogoYConstraint // save original value
        keyboardIsVisible = true
        pursuitLogoYConstraint.constant -= (height * 0.5)
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        pursuitLogoYConstraint.constant -= originalYConstraint.constant
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

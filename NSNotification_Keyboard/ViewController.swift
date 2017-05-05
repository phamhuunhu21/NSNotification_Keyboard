//
//  ViewController.swift
//  NSNotification_Keyboard
//
//  Created by Kiet Nguyen on 5/5/17.
//  Copyright © 2017 Group9_iOSUTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyBoard))
        view.addGestureRecognizer(dismiss)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: self.view.window)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyBoard(){
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification){
        let userInfo = sender.userInfo
        
        let keyboardSize: CGSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let offset: CGSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        if(keyboardSize.height == offset.height){
            UIView.animate(withDuration: 0.1, animations: {() ->Void in
                self.view.frame.origin.y -= keyboardSize.height
            })
        }
        else{
            UIView.animate(withDuration: 0.1, animations: {() ->Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
    }
    
    func keyboardWillHide(sender: NSNotification){
        let userInfo = sender.userInfo
        
        let keyboardSize: CGSize = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        self.view.frame.origin.y += keyboardSize.height
        
    }

}


//
//  MainVC.swift
//  TnightProject
//
//  Created by Rajat Dhasmana on 02/03/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    
//MARK: IBOutlets
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var screenScrollView: UIScrollView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var scrollLineView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
//MARK: App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.backgroundColor = UIColor.clear
        signUpButton.backgroundColor = UIColor.clear
        self.screenScrollView.delegate = self
        self.setupSubviews()
    }
    
//MARK: Setup Subview
    
    private func setupSubviews() {
    
        let signInController = self.storyboard?.instantiateViewController(withIdentifier: "SignInVCID") as! SignInVC
        
        self.screenScrollView.addSubview(signInController.view)
        signInController.willMove(toParentViewController: self)
        self.addChildViewController(signInController)
        signInController.didMove(toParentViewController: self)
        signInController.view.frame = CGRect(x: 0, y: 0, width: self.screenScrollView.frame.width, height: self.screenScrollView.frame.height)
        
        let signUpController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCID") as! SignUpVC
        self.screenScrollView.addSubview(signUpController.view)
        signUpController.willMove(toParentViewController: self)
        self.addChildViewController(signUpController)
        signUpController.didMove(toParentViewController: self)
        signUpController.view.frame = CGRect(x: self.screenScrollView.frame.width, y: 0, width: self.screenScrollView.frame.width, height: self.screenScrollView.frame.height)
        
        self.screenScrollView.frame.size = CGSize(width: self.view.frame.width, height: 324)
        
        signInController.view.frame.origin = CGPoint.zero
        signUpController.view.frame.origin = CGPoint(x: screenScrollView.bounds.width, y: 0)
        
        
        self.screenScrollView.contentSize = CGSize(width: (self.screenScrollView.frame.width) * 2, height: self.screenScrollView.frame.height)
    
//.....................changing height during keyboard view...............
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (Notification) in
            
            guard let userinfo = Notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
                else {
                    
                    return
                    
            }
            
            
            
            let keyboardheight = userinfo.cgRectValue.height
            
            
            UIView.animate(withDuration: 0.8, animations: {
                
                self.scrollBottomConstraint.constant = keyboardheight
           
            })
            
            
        }
        
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (Notification) in
            
            
            UIView.animate(withDuration: 0.8, animations: { 
               
                self.scrollBottomConstraint.constant = 0
                
            })
            
            
        }
        
        
        signUpController.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: SignIn Button Tapped
    
    @IBAction func signInButtonTapped(_ sender: Any) {
    
    self.screenScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    
    }
    
//MARK: SignUp Button Tapped
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
   
    
    self.screenScrollView.setContentOffset(CGPoint(x: self.screenScrollView.frame.width, y: 0), animated: true)
    
    }
    
//MARk: Target for login Button
    
    func loginButtonTapped(button : UIButton) {
        
        self.screenScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        
    }
}

//MARK: extension MainVC : UIScrollViewDelegate

extension MainVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let multiplier = self.screenScrollView.frame.width/self.scrollLineView.frame.width
        
        let scrollPoint = scrollView.contentOffset.x
        
        self.scrollLineView.transform = CGAffineTransform(translationX: scrollPoint/multiplier, y: 0)
        
        
    }
    
    
}


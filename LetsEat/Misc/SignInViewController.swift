//
//  SignInViewController.swift
//  LetsEat
//
//  Created by עלאא דאהר on 06/08/2020.
//  Copyright © 2020 AlaaDaher. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    var appleIDGivenName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        displaySignInWithAppleButton()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabController = segue.destination as? UITabBarController, let navController = tabController.viewControllers?[0] as? UINavigationController, let viewcontroller = navController.viewControllers[0] as? ExploreViewController {
            viewcontroller.givenName = appleIDGivenName
        }
        
    }
    
    func displaySignInWithAppleButton() {
        let appleIDButton = ASAuthorizationAppleIDButton()
        appleIDButton.translatesAutoresizingMaskIntoConstraints = false
        appleIDButton.addTarget(self, action: #selector(appleIDButtonTapped), for: .touchUpInside)
        view.addSubview(appleIDButton)
        
    NSLayoutConstraint.activate([appleIDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), appleIDButton.centerYAnchor.constraint(equalTo: view.centerYAnchor), appleIDButton.widthAnchor.constraint(equalToConstant: 250.0)])
        
        
    }
    
    @objc func appleIDButtonTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    
// MARK: - Sign In With Apple
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case  let credential as ASAuthorizationAppleIDCredential:
            print(credential.fullName?.givenName ?? "No given name provided")
            print(credential.fullName?.familyName ?? "No family name provided")
            print(credential.user)
            print(credential.email ?? "No email provided")
            
            appleIDGivenName = credential.fullName?.givenName
            
            performSegue(withIdentifier: "signin", sender: nil)
        default:
            break
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple ID Authentication failed", error)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    

}

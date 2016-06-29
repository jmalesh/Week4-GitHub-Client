//
//  AppDelegate.swift
//  GoGoGitHub
//
//  Created by Jess Malesh on 6/27/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?    
    var viewController: ViewController?
    var homeViewController: HomeViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.checkOAuthStatus()
        return true
    }

    func application(app: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        GitHubOAuth.shared.tokenRequestWithCallback(url, options: SaveOptions.userDefaults) { (success) -> () in
            
            if success{
                if let viewController = self.viewController{
                    UIView.animateWithDuration(0.4, delay: 1.0, options: .CurveEaseInOut, animations: {
                        
                        self.homeViewController?.navigationController?.navigationBarHidden = false
                        
                        viewController.view.alpha = 0.0
                        }, completion: { (finished) in
                            viewController.view.removeFromSuperview()
                            viewController.removeFromParentViewController()
                    })
                }
            }
        }
        return true 
    }
    
    func checkOAuthStatus() //user logged in out not?
    {
        
        do {
            if let token = try GitHubOAuth.shared.accessToken() {
                print(token)
            }
        }
        
        
        catch {
            self.presentViewController() }
        }
        
        func presentViewController()
        {
            
            guard let navigationController = self.window?.rootViewController as? UINavigationController else {
                fatalError("Check your root view controller...")
            }
            
            navigationController.navigationBarHidden = true
    
            guard let homeViewController = navigationController.viewControllers.first as? HomeViewController else {
                fatalError("Home VC?")
            }
    
            
            guard let storyboard = homeViewController.storyboard else {
                fatalError("Check for storyboard...")
            }
            
            guard let viewController = storyboard.instantiateViewControllerWithIdentifier(ViewController.id) as? ViewController else {
                fatalError("Check scene identifier...")
            }
            
            homeViewController.addChildViewController(viewController)
            homeViewController.view.addSubview(viewController.view)            
            viewController.didMoveToParentViewController(homeViewController)
            
            self.homeViewController = homeViewController
            self.viewController = viewController
        }
    
    
    }





















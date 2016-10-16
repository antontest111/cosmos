//
//  AppDelegate.swift
//  Cosmos
//
//  Created by Anton Selyanin on 15/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var rootViewController: UITabBarController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
        guard NSClassFromString("XCTestCase") == nil else { return true }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        rootViewController = UITabBarController(nibName: nil, bundle: nil)
        
        
        rootViewController?.viewControllers = [
            configureTab(withName: "Employees", image: nil, controller: createEmployees()),
            configureTab(withName: "Gallery", image: nil, controller: UIViewController()),
            configureTab(withName: "Service", image: nil, controller: UIViewController())
        ]
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func createEmployees() -> UIViewController {
        let service = EmployeeService()
        let presenter = EmployeesListPresenter(service: service)

        let controller = EmployeesListController(presenter: presenter)
        controller.title = "Employees"

        presenter.selectedEmployee = { [weak controller] employee in
            let presenter = ManageEmployeePresenter(employee: employee, service: service)
            let manage = ManageEmployeeController(presenter: presenter)
            controller?.navigationController?.pushViewController(manage, animated: true)
        }
        
        
        return UINavigationController(rootViewController: controller)
    }
}

private func configureTab(withName name: String, image: UIImage?, controller: UIViewController) -> UIViewController {
    controller.tabBarItem = UITabBarItem(title: name, image: image, selectedImage: image)
    return controller
}

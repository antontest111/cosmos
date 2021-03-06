//
//  AppDelegate.swift
//  Cosmos
//
//  Created by Anton Selyanin on 15/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    
        guard NSClassFromString("XCTestCase") == nil else { return true }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        Persistence.setup()
        
        window?.rootViewController = createRootController()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func createRootController() -> UIViewController {
        let rootViewController = UITabBarController(nibName: nil, bundle: nil)
        rootViewController.viewControllers = [
            configureTab(withName: "Employees", image: UIImage(named: "employees"), controller: createEmployees()),
            configureTab(withName: "Gallery", image: UIImage(named: "gallery"), controller: createGallery()),
            configureTab(withName: "Service", image: UIImage(named: "quotes"), controller: createQuotes())
        ]
        
        return rootViewController
    }
    
    private func createEmployees() -> UIViewController {
        let realm = try! Realm()
        
        let service = EmployeeService(realm: realm)
        let presenter = EmployeesListPresenter(service: service)

        let controller = EmployeesListController(presenter: presenter)
        controller.title = "Employees"

        presenter.selectedEmployee = { [weak controller] employee in
            let service = ManageEmployeeService(employee: employee, realm: realm, dataService: service)
            let presenter = ManageEmployeePresenter(service: service)
            let manage = ManageEmployeeController(presenter: presenter)
            controller?.navigationController?.pushViewController(manage, animated: true)
        }
        
        presenter.addNewEmployee = { [weak controller] in
            let service = ManageEmployeeService(employee: Manager(), realm: realm, dataService: service)
            let presenter = ManageEmployeePresenter(service: service)
            let manage = ManageEmployeeController(presenter: presenter)
            controller?.navigationController?.pushViewController(manage, animated: true)
        }
        
        return UINavigationController(rootViewController: controller)
    }
    
    private func createGallery() -> UIViewController {
        let controller = GalleryViewController(presenter: GalleryPresenter())
        controller.title = "Gallery"
        
        return UINavigationController(rootViewController: controller)
    }
    
    private func createQuotes() -> UIViewController {
        let presenter = FeedPresenter()
        let controller = FeedViewController(presenter: presenter)
        controller.title = "Service"
        
        return UINavigationController(rootViewController: controller)
    }
}

private func configureTab(withName name: String, image: UIImage?, controller: UIViewController) -> UIViewController {
    controller.tabBarItem = UITabBarItem(title: name, image: image, selectedImage: image)
    return controller
}

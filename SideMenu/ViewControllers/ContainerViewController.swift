//
//  ContainerViewController.swift
//  SideMenu
//
//  Created by Shuaiqing Luo on 12/16/23.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "test"
        addChildVCs()
    }

    private func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu()
    }
    
    func toggleMenu(completion: (() -> Void)? = nil) {
        guard let navVC else { return }
        // Animate the menu
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                navVC.view.frame.origin.x = navVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                navVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in
            guard let self else { return }
            switch menuItem {
            case .home:
                infoVC.view.removeFromSuperview()
                infoVC.didMove(toParent: nil)
                homeVC.title = "Home"
            case .info:
                // Add info child
                homeVC.addChild(infoVC)
                homeVC.view.addSubview(infoVC.view)
                infoVC.view.frame = homeVC.view.bounds
                infoVC.didMove(toParent: homeVC)
                homeVC.title = infoVC.title
            case .appRating:
                break
            case .shareApp:
                break
            case .settings:
                break
            }
        }
    }
}

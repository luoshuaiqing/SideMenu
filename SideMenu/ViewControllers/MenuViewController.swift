//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Shuaiqing Luo on 12/16/23.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case settings = "Settings"
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//
//  ViewController.swift
//  UsersAndPhotos
//
//  Created by Александр Жуков on 25.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let parser = Parser()
    var users: Users?
    var names: [String]?
    
    private var tableView: UITableView!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.refreshControl = refreshControl
        configureView()
        loadUsers(searchUrl: listUrl)
    }
    
    func configureView() {
        self.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        tableView.refreshControl = refreshControl

        self.view.addSubview(tableView)
    }
    
    
    func loadUsers(searchUrl: String){
        self.parser.parseUsers(url: searchUrl) { users in
            guard let users = users else { return }
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    @objc func reload(refreshControl: UIRefreshControl) {
        loadUsers(searchUrl: listUrl)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let users = users![indexPath.row]
        cell.textLabel!.text = users.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users![indexPath.row]
        let viewController = PhotosViewController()
        viewController.userName = user.name
        viewController.userID = user.id
        navigationController?.pushViewController(viewController, animated: true)
    }
}

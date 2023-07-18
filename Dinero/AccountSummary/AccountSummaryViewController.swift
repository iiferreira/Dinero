//
//  AccountSummaryViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit


class AccountSummaryViewController : UIViewController {
    
    
    let names = ["Iuri","Aldo","Ygor"]
    
    let tableView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    func setup() {
        self.view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    
}

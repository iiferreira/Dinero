//
//  AccountSummaryViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit


class AccountSummaryViewController : UIViewController {
    
    
    var accounts : [AccountSummaryTableViewCell.ViewModel] = []
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        
    }
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = AccountSummaryTableViewCell.rowHeight
        tableView.tableFooterView = UIView()
    }
    
    private func layout() {
        self.view.backgroundColor = .clear
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else { return  UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.cellIdentifier, for: indexPath) as! AccountSummaryTableViewCell
        
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    
}

extension AccountSummaryViewController {
    
    private func fetchData() {
        let savings = AccountSummaryTableViewCell.ViewModel(accountType: .Banking,
                                                            accountName: "Basic Savings", balance: 929466.23)
        
        let visa = AccountSummaryTableViewCell.ViewModel(accountType: .CreditCard,
                                                         accountName: "Visa Card", balance: 25000.52)
        
        let investment = AccountSummaryTableViewCell.ViewModel(accountType: .Investment,
                                                               accountName: "Deposit", balance: 3290.99)
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(investment)
    }
    
}

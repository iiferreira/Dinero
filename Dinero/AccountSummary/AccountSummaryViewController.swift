//
//  AccountSummaryViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit


class AccountSummaryViewController : UIViewController {
    
    // Request Models
    var profile : Profile?
    
    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    
    var accounts : [AccountSummaryTableViewCell.ViewModel] = []
    
    let tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    
    lazy var logoutBarButtonItem : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        var insets = view.safeAreaInsets
        insets.top = 0
        tableView.contentInset = insets
    }
    
    
}

extension AccountSummaryViewController {
    
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        //fetchAccounts()
        fetchDataAndLoadViews()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
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
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
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


//MARK: -ACTIONS

extension AccountSummaryViewController {
    @objc func logoutTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

//MARK: - Networking
extension AccountSummaryViewController {
    private func fetchDataAndLoadViews() {
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        fetchData()
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
}

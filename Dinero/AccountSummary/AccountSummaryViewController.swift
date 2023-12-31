//
//  AccountSummaryViewController.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit


enum alertError  {
    case invalidResponse
    case decodingError
}

class AccountSummaryViewController : UIViewController {
    
    //Request Models
    var profile : Profile?
    var accounts : [Account] = []

    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels : [AccountSummaryTableViewCell.ViewModel] = []
    
    //Components
    let tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    
    //Networking
    let profileManager = ProfileManager()
    let accountManager = AccountManager()
    
    //Error alert
    lazy var errorAlert : UIAlertController = {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }()
    
    var isLoaded = false
    
    lazy var logoutBarButtonItem : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
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
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        setupRefreshControl()
        setupSkeletons()
        fetchData()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.cellIdentifier)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension AccountSummaryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accountCellViewModels.isEmpty else { return  UITableViewCell() }
        if isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.cellIdentifier, for: indexPath) as! AccountSummaryTableViewCell
            
            let account = accountCellViewModels[indexPath.row]
            cell.configure(with: account)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
        return cell
    }
}

extension AccountSummaryViewController : UITableViewDelegate {
    
}

//MARK: - Networking
extension AccountSummaryViewController {
    private func fetchData() {
        
        let group = DispatchGroup()
        
        let randomUser = String(Int.random(in: 1..<4))
        
        group.enter()
        profileManager.fetchProfile(forUserId: randomUser) { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
        group.leave()
        }
        group.enter()
        accountManager.fetchAccounts(forUserId: randomUser) { result in
            switch result {
            case .success( let accounts ):
                self.accounts = accounts
                self.configureTableCells(with: accounts)
            case .failure( let error ):
                self.displayError(error)
            }
        group.leave()
        }
        group.notify(queue: .main) {
            self.isLoaded = true
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountCellViewModels = accounts.map({
            AccountSummaryTableViewCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        })
    }
}


//MARK: - Error handling and skeleton setup.
extension AccountSummaryViewController {
    private func displayError(_ error: NetworkError) {
        
        let titleAndMessageErrorMsg = titleAndMessageErrorMsg(error)
        self.showErrorAlert(withTitle: titleAndMessageErrorMsg.0,
                            message: titleAndMessageErrorMsg.1)
    }
    
    private func titleAndMessageErrorMsg(_ error:NetworkError) -> (String,String) {
        let alertTitle: String
        let alertMessage: String
        
        switch error {
        case .serverError:
            alertTitle = "Internet error"
            alertMessage = "Can't Connect to server"
        case .decodingError:
            alertTitle = "Decoding error"
            alertMessage = "Can't decode data"
        }
        
        return (alertTitle, alertMessage)
    }
    
    private func showErrorAlert(withTitle title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel)
//        alert.addAction(action)
        errorAlert.title = title
        errorAlert.message = message
        present(errorAlert, animated: true)
        
    }
    
    private func setupSkeletons() {
            let row = Account.makeSkeleton()
            accounts = Array(repeating: row, count: 10)
            
            configureTableCells(with: accounts)
    }
}


//MARK: -ACTIONS
extension AccountSummaryViewController {
    @objc func logoutTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    @objc func refreshContent() {
        reset()
        setupSkeletons()
        self.tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
}


//MARK: - Unit testing
extension AccountSummaryViewController {
    func titleAndMessageErrorMsgForTesting(_ error:NetworkError) -> (String,String) {
        return titleAndMessageErrorMsg(error)
    }    

}

//
//  AccountSummaryTableViewCell.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit

class AccountSummaryTableViewCell : UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType : AccountType
        let accountName : String
        let balance : Decimal
        
        var balanceAsAttributedString : NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    let viewModel : ViewModel? = nil
    
    static let cellIdentifier = "cellIdentifier"
    static let rowHeight : CGFloat = 100
    
    let underlineView = UIView()

    let typeLabel = UILabel()
    let nameLabel = UILabel()
    
    let balanceLabeL = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    let trailingStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AccountSummaryTableViewCell.cellIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryTableViewCell {
    
    private func setup() {
        
        trailingStackView.spacing = 2
        trailingStackView.axis = .vertical
        trailingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = appColor
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Account type"
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Account name"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        balanceLabeL.translatesAutoresizingMaskIntoConstraints = false
        balanceLabeL.text = "Balance"
        balanceLabeL.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabeL.textAlignment = .right
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "XXX,XXX", cents: "XX")
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.tintColor = appColor

    }
    
    private func layout() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(trailingStackView)
        contentView.addSubview(chevronImageView)
        trailingStackView.addArrangedSubview(balanceLabeL)
        trailingStackView.addArrangedSubview(balanceAmountLabel)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor),
            underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underlineView.widthAnchor.constraint(equalToConstant: 50),
            underlineView.heightAnchor.constraint(equalToConstant: 3.5)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            trailingStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingStackView.trailingAnchor, multiplier: 3)
        
        ])
        
        NSLayoutConstraint.activate([
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.trailingAnchor.constraint(equalTo: chevronImageView.trailingAnchor, constant: 2)
        ])
        
    }
    
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes : [ NSAttributedString.Key : Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset:4]
        let dollarAttributes : [ NSAttributedString.Key : Any] = [.font: UIFont.preferredFont(forTextStyle: .title3)]
        let centAttributes : [ NSAttributedString.Key : Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset:4]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSMutableAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryTableViewCell {
    func configure(with vm: ViewModel) {
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .Banking:
            underlineView.backgroundColor = appColor
            balanceLabeL.text = "Current balance"
        case .CreditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabeL.text = "Current balance"
        case .Investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabeL.text = "Some balance"
        }
    }
}


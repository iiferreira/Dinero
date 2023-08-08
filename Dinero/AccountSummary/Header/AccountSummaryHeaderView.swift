//
//  AccountSummaryHeaderView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit

class AccountSummaryHeaderView : UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    let ShakeyBell = ShakeyBellView()
    
    struct ViewModel {
        let welcomeMessage : String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupShakeyBell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
       
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupShakeyBell() {
        addSubview(ShakeyBell)
        ShakeyBell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalToSystemSpacingBelow: ShakeyBell.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalTo: ShakeyBell.trailingAnchor, constant: 10),
            ShakeyBell.widthAnchor.constraint(equalToConstant: 24),
            ShakeyBell.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

extension AccountSummaryHeaderView {
    func configure(viewModel: ViewModel) {
        DispatchQueue.main.async {
            self.welcomeLabel.text = viewModel.welcomeMessage
            self.nameLabel.text = viewModel.name
            self.dateLabel.text = viewModel.dateFormatted
        }
        
    }
}

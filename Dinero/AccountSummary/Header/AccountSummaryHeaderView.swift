//
//  AccountSummaryHeaderView.swift
//  Dinero
//
//  Created by Iuri Ferreira on 18/07/23.
//

import UIKit

class AccountSummaryHeaderView : UIView {
    
    @IBOutlet var contentView: UIView!
    
    let ShakeyBell = ShakeyBellView()
    
    
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
            bottomAnchor.constraint(equalToSystemSpacingBelow: ShakeyBell.bottomAnchor, multiplier: 0.5),
            trailingAnchor.constraint(equalTo: ShakeyBell.trailingAnchor, constant: 0.5),
            ShakeyBell.widthAnchor.constraint(equalToConstant: 24),
            ShakeyBell.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
}

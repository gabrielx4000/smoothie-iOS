//
//  FruitsTableViewCell.swift
//  Presentation
//
//  Created by gxavier on 10/10/22.
//

import SnapKit
import UIKit

public class FruitsTableViewCell: UITableViewCell {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Colors.textPrimary.rawValue
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildMainStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(contentView.safeAreaLayoutGuide.snp.right).offset(-20)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalTo(contentView.safeAreaLayoutGuide.snp.left).offset(20)
        }
    }
    
}

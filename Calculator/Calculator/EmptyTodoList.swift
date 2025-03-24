//
//  EmptyTodoList.swift
//  Calculator
//
//  Created by David on 24.3.25..
//

import UIKit

class EmptyTodoList: UIView {
    
    lazy var youAreFree: UILabel = {
        let youAreFree = UILabel()
        youAreFree.text = "Horrayy you are freeeee 🎉"
        youAreFree.textAlignment = .center
        youAreFree.translatesAutoresizingMaskIntoConstraints = false
        return youAreFree
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(youAreFree)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

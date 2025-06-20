//
//  CloseIconView.swift
//  TodoApp
//
//  Created by Admin on 6/20/25.
//

import Foundation
import UIKit


class CloseIconView: UIButton {
    init() {
        super.init(frame: .zero)
        
        let image = UIImage(named: "Close")?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = .black
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        

        self.imageView?.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

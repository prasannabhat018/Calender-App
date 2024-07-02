//
//  LabelButton.swift
//  zeta project
//
//  Created by Prasanna Bhat on 02/07/24.
//

import Foundation
import UIKit

class LabelButton: UILabel {
    var onClick: (Int?, LabelButton) -> Void
    var labelText: Int?
    var applyBackground: Bool = false {
        didSet {
            if applyBackground {
                backgroundColor = .lightGray
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    init(labelText: Int?, onClick: @escaping (Int?, LabelButton) -> Void) {
        self.onClick = onClick
        self.labelText = labelText
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        if let labelText {
            text = String(labelText)
        }
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick(labelText, self)
    }
}

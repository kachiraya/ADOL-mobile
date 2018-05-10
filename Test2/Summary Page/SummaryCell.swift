//
//  SummaryCell.swift
//  Test2
//
//  Created by Monrada Juycharoen on 3/1/2561 BE.
//  Copyright © 2561 Monrada Juycharoen. All rights reserved.
//

import FoldingCell
import UIKit

class SummaryCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        // Initialization code
    }


    var number: Int = 0
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}

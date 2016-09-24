//
//  AccordionCellsDataClass.swift
//  PhraseBookAccordion
//
//  Created by Bolat Ashim on 8/20/16.
//  Copyright © 2016 Bolat Ashim. All rights reserved.
//

import Foundation
import UIKit


class AccordionCellsDataClass {
    static var elementsArray: [AccordionCell] = []
}

class AccordionCell{

}

class SecondaryCell: AccordionCell {
    var cellLabel: String
    var buttonImage: UIImage
    var invisible: Bool = true
    
    init (cellLabel: String, buttonImage: UIImage){
        self.cellLabel = cellLabel
        self.buttonImage = buttonImage
    }
}



class PrimaryCell: AccordionCell {
    var cellLabel: String
    var invisible: Bool = false
    init(cellLabel: String) {
        self.cellLabel = cellLabel
    }
}






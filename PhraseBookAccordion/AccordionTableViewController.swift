//
//  AccordionTableViewController.swift
//  PhraseBookAccordion
//
//  Created by Bolat Ashim on 8/20/16.
//  Copyright © 2016 Bolat Ashim. All rights reserved.
//

import Foundation
import UIKit


class AccordionTableViewController: UITableViewController {

    
    var previousSelection: Int?
    
    var parentCellHeight: Int = 60
    var childCellHeight: Int = 50
    
    
    
    
    override func viewDidLoad() {

        

        let parentCell = PrimaryCell(cellLabel: "Title 1")
        AccordionCellsDataClass.elementsArray.append(parentCell)
        
        let firstChildButtonImage = UIImage(named: "speaker") as UIImage?
        let firstChildCell = SecondaryCell(cellLabel: "Child cell 1", buttonImage: firstChildButtonImage!)
        
        let secondChildButtonImage = UIImage(named: "favorite") as UIImage?
        let secondChildCell = SecondaryCell(cellLabel: "Child cell 2", buttonImage: secondChildButtonImage!)
        
        AccordionCellsDataClass.elementsArray.append(firstChildCell)
        AccordionCellsDataClass.elementsArray.append(secondChildCell)
    
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccordionCellsDataClass.elementsArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellInfoContainingObject = AccordionCellsDataClass.elementsArray[indexPath.row]
        if let previousSelection = previousSelection{
            print(previousSelection)
        }
    
        if cellInfoContainingObject is SecondaryCell {
            let myCell = cellInfoContainingObject as! SecondaryCell
            let cell = tableView.dequeueReusableCellWithIdentifier("secondary", forIndexPath: indexPath) as! SecondaryAccordionTableViewCell
            let cellLabelText = myCell.cellLabel
            let cellButtonImage = myCell.buttonImage
            cell.secondaryCellLabel.text = cellLabelText
            //cell.secondaryCellButton.frame.size.width = CGFloat(35)
            //cell.secondaryCellButton.frame.size.width = CGFloat(35)
            cell.secondaryCellButton.setImage(cellButtonImage, forState: .Normal)
            cell.secondaryCellButton.imageEdgeInsets = UIEdgeInsetsMake(40, 45, 40, 45)
            cell.openPhraseIndex = self.previousSelection
            return cell
        }else{
        
            let myCell = cellInfoContainingObject as! PrimaryCell
            let cell = tableView.dequeueReusableCellWithIdentifier("primary", forIndexPath: indexPath) as! PrimaryAccordionTableViewCell
            let cellLabelText = myCell.cellLabel
            cell.primaryCellLabel.text = cellLabelText
            return cell
        }
    }
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = AccordionCellsDataClass.elementsArray[indexPath.row]
        
        if cell is PrimaryCell {
            return CGFloat(parentCellHeight)
        }
        if cell is SecondaryCell {
            let myCell = cell as! SecondaryCell
            if myCell.invisible {
                return 0
            }
        }
        return CGFloat(childCellHeight)
    }
    
    
    func expandTwoFollowingCells(primaryCellIndex: Int){
        let cellOne = AccordionCellsDataClass.elementsArray[primaryCellIndex + 1] as! SecondaryCell
        let cellTwo = AccordionCellsDataClass.elementsArray[primaryCellIndex + 2] as! SecondaryCell
        cellOne.invisible = false
        cellTwo.invisible = false
    }
    
    
    func collapseTwoFollowingCells(primaryCellIndex: Int) {
        
        let cellOne = AccordionCellsDataClass.elementsArray[primaryCellIndex + 1] as! SecondaryCell
        let cellTwo = AccordionCellsDataClass.elementsArray[primaryCellIndex + 2] as! SecondaryCell
        cellOne.invisible = true
        cellTwo.invisible = true
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = AccordionCellsDataClass.elementsArray[indexPath.row]
        let numOfCells = AccordionCellsDataClass.elementsArray.count
        if cell is PrimaryCell {
            if let prev = previousSelection {
                if prev == indexPath.row {
                    let theCell = AccordionCellsDataClass.elementsArray[indexPath.row + 1] as! SecondaryCell
                    if theCell.invisible{
                        expandTwoFollowingCells(prev)
                    }else{
                        collapseTwoFollowingCells(prev)
                    }
                }else{
                    collapseTwoFollowingCells(prev)
                    expandTwoFollowingCells(indexPath.row)
                }
                previousSelection = indexPath.row
            }else{
                expandTwoFollowingCells(indexPath.row)
                previousSelection = indexPath.row
            }
        }
        self.tableView.beginUpdates()
        print("in betewen")
        self.tableView.endUpdates()
        print("out")
        if indexPath.row < AccordionCellsDataClass.elementsArray.count - 2{
            if indexPath.row+3 == numOfCells{
                let location = NSIndexPath(forRow: indexPath.row + 2, inSection: indexPath.section)
                self.tableView.scrollToRowAtIndexPath(location, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }else if indexPath.row == 0{
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            }
        }
    }
}

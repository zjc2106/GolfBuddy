//
//  ThirdViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/8/22.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var holeNumButton: UISegmentedControl!
    @IBOutlet weak var roundTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTextBox.adjustsFontSizeToFitWidth = true
    }
    
    @IBAction func startRound(_ sender: Any) {
        // set up variables
        Variables.totalHoles = (holeNumButton.titleForSegment(at: holeNumButton.selectedSegmentIndex)! as NSString).integerValue
        Variables.totalFairways = Variables.totalHoles
        Variables.roundName = roundTextBox.text ?? "<no-name>"
        Variables.putts = 0.0
        Variables.fairwaysHit = 0.0
        Variables.greensHit = 0.0
        Variables.strokes = 0.0
        Variables.hole = 1
        Variables.par = 0.0
    }
}

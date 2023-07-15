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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startRound(_ sender: Any) {
        Variables.totalHoles = (holeNumButton.titleForSegment(at: holeNumButton.selectedSegmentIndex)! as NSString).integerValue
        Variables.totalFairways = Variables.totalHoles
        Variables.roundName = roundTextBox.text ?? "<no-name>"
        
        Variables.putts = 0.0
        Variables.fairwaysHit = 0.0
        Variables.greensHit = 0.0
        Variables.strokes = 0.0
        Variables.hole = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

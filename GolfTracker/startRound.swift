//
//  ThirdViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/8/22.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var holeNumButton: UISegmentedControl!
    @IBOutlet weak var roundTextBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        roundTextBox.adjustsFontSizeToFitWidth = true
        roundTextBox.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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

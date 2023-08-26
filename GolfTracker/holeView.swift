//
//  SecondViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/1/22.
//

import UIKit
import RealmSwift


// extension to allow rgb values in UIColor
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class SecondViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    // stroke values
    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    let realm = try! Realm()

    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var fairwayLabel: UILabel!
    @IBOutlet weak var fairwaySwitch: UISwitch!
    @IBOutlet weak var girSwitch: UISwitch!
    @IBOutlet weak var puttSwitch: UISegmentedControl!
    @IBOutlet weak var scorePicker: UIPickerView!
    @IBOutlet weak var finishRoundButton: UIButton!
    @IBOutlet weak var nextHoleButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var parSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Variables.hole = 1
        holeLabel.text = "Hole \(Variables.hole)"
        scorePicker.delegate = self
        scorePicker.dataSource = self
        finishRoundButton.isHidden = true
        parSwitch.selectedSegmentIndex = 1
    }
    
    func numberOfComponents(in scorePicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ scorePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ scorePicker: UIPickerView, titleForRow row: Int,
        forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func nextHole(_ sender: Any) {
        var holeScore = 0.0
        
        // extract all values from buttons and switches
        let holePar = (parSwitch.titleForSegment(at: parSwitch.selectedSegmentIndex)! as NSString).doubleValue
        
        if(fairwaySwitch.isEnabled) {
            if(fairwaySwitch.isOn) {
                Variables.fairwaysHit = Variables.fairwaysHit + 1
            }
        }
        if(!fairwaySwitch.isEnabled) {
            Variables.totalFairways = Variables.totalFairways-1
        }
        if(girSwitch.isOn) {
            Variables.greensHit = Variables.greensHit+1
        }
        
        let holePutts = (puttSwitch.titleForSegment(at: puttSwitch.selectedSegmentIndex)! as NSString).doubleValue
        
        let rowIdx = scorePicker.selectedRow(inComponent: 0)
        
        holeScore = (pickerData[rowIdx] as NSString).doubleValue

        // updates Variables (round aggregates)
        Variables.strokes = Variables.strokes + holeScore
        Variables.putts = Variables.putts + holePutts
        Variables.hole = Variables.hole + 1
        Variables.par = Variables.par + holePar
        
        holeLabel.text = "Hole \(Variables.hole)"
        
        // check if hole is last
        if(Variables.hole == Variables.totalHoles) {
            finishRoundButton.isHidden = false
            nextHoleButton.isHidden = true
        }
        // reset all buttons to normal
        fairwaySwitch.isOn = false
        fairwaySwitch.isEnabled = true
        if(self.traitCollection.userInterfaceStyle == .dark) {
            fairwayLabel.textColor = UIColor(rgb: 0xCC9966)
        }
        else{
            fairwayLabel.textColor = UIColor(rgb: 0xCC9966)
        }
        girSwitch.isOn = false
        puttSwitch.selectedSegmentIndex = 0
        parSwitch.selectedSegmentIndex = 1
        
    }
    
    // grays fairway switch if par 3
    @IBAction func parSwitched(_ sender: Any) {
        let holePar = (parSwitch.titleForSegment(at: parSwitch.selectedSegmentIndex)! as NSString).doubleValue
        if holePar == 3.0{
            fairwayLabel.textColor = UIColor.lightGray
            fairwaySwitch.isOn = false
            fairwaySwitch.isEnabled = false
        }
        else {
            fairwaySwitch.isEnabled = true
            if(self.traitCollection.userInterfaceStyle == .dark) {
                fairwayLabel.textColor = UIColor(rgb: 0xCC9966)
            }
            else{
                fairwayLabel.textColor = UIColor(rgb: 0xCC9966)
            }
        }
        
    }
    
    // adds data to database when round is finished
    @IBAction func finishRound(_ sender: Any) {
        // gets all data from last hole
        var holeScore = 0.0
        if(fairwaySwitch.isEnabled) {
            if(fairwaySwitch.isOn) {
                Variables.fairwaysHit = Variables.fairwaysHit + 1
            }
        }
        if(!fairwaySwitch.isEnabled) {
            Variables.totalFairways = Variables.totalFairways-1
        }
        if(girSwitch.isOn) {
            Variables.greensHit = Variables.greensHit+1
        }
        
        let holePutts = (puttSwitch.titleForSegment(at: puttSwitch.selectedSegmentIndex)! as NSString).doubleValue
        
        let rowIdx = scorePicker.selectedRow(inComponent: 0)
        
        holeScore = (pickerData[rowIdx] as NSString).doubleValue

        let holePar = (parSwitch.titleForSegment(at: parSwitch.selectedSegmentIndex)! as NSString).doubleValue
        
        // updates variables to keep track
        Variables.par = Variables.par + holePar
        Variables.strokes = Variables.strokes + holeScore
        Variables.putts = Variables.putts + holePutts
        
        let roundDate =  Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let testDate = dateFormatter.string(from: roundDate)
        // adds data to realm database
        try! realm.write {
            let round = Round()
            round.fairwaysHit = Int(Variables.fairwaysHit)
            round.totalHoles = Int(Variables.totalHoles)
            round.putts = Int(Variables.putts)
            round.greensHit = Int(Variables.greensHit)
            round.strokes = Int(Variables.strokes)
            round.roundName = Variables.roundName
            round.totalFairways = Variables.totalFairways
            round.date = testDate
            round.par = Int(Variables.par)
            realm.add(round)
        }
    }
    

    // Function if home is pressed, add an alert so that user doesn't automatically lose progress
    @IBAction func homePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Woah!", message: "If you go home, you will lose this round's progreess.", preferredStyle: .alert)
        
        let stayAction = UIAlertAction(title: "Continue Round", style: .default) {
            (action) in
            print(action)
        }
        
        let goAction = UIAlertAction(title: "Go Home", style: .default) {
            (action) in
            self.performSegue(withIdentifier: "roundToHome", sender: self)
        }
        
        alert.addAction(stayAction)
        alert.addAction(goAction)
        present(alert, animated: true, completion: nil)
    }
}

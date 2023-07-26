//
//  SecondViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/1/22.
//

import UIKit
import RealmSwift


class SecondViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    let realm = try! Realm()

    
    @IBOutlet weak var holeLabel: UILabel!
    
    @IBOutlet weak var fairwayLabel: UILabel!
    
//    @IBOutlet weak var par3Switch: UISwitch!
    
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
//        print(Variables.hole)
        Variables.hole = 1
        holeLabel.text = "Hole \(Variables.hole)"
        // Do any additional setup after loading the view.
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
        
        Variables.putts = Variables.putts + holePutts
//        func pickerView(_ scorePicker: UIPickerView, didSelectRow row: Int, forComponent component: Int) -> String? {
//            return pickerData[row]
//        }
        let rowIdx = scorePicker.selectedRow(inComponent: 0)
        
        holeScore = (pickerData[rowIdx] as NSString).doubleValue

        Variables.strokes = Variables.strokes + holeScore

        Variables.hole = Variables.hole + 1
        Variables.par = Variables.par + holePar
        holeLabel.text = "Hole \(Variables.hole)"
        if(Variables.hole == Variables.totalHoles) {
            finishRoundButton.isHidden = false
            nextHoleButton.isHidden = true
        }
//        par3Switch.isOn = false
        fairwaySwitch.isOn = false
        fairwaySwitch.isEnabled = true
        if(self.traitCollection.userInterfaceStyle == .dark) {
            fairwayLabel.textColor = UIColor.white
        }
        else{
            fairwayLabel.textColor = UIColor.black
        }
        girSwitch.isOn = false
        puttSwitch.selectedSegmentIndex = 0
        parSwitch.selectedSegmentIndex = 1
        print(holePar)
        print(Variables.par)
        
    }
    
    @IBAction func parSwitched(_ sender: Any) {
        var holePar = (parSwitch.titleForSegment(at: parSwitch.selectedSegmentIndex)! as NSString).doubleValue
        if holePar == 3.0{
            fairwayLabel.textColor = UIColor.lightGray
            fairwaySwitch.isOn = false
            fairwaySwitch.isEnabled = false
        }
        else {
            fairwaySwitch.isEnabled = true
            if(self.traitCollection.userInterfaceStyle == .dark) {
                fairwayLabel.textColor = UIColor.white
            }
            else{
                fairwayLabel.textColor = UIColor.black
            }
        }
        
    }
//    @IBAction func par3Switched(_ sender: Any) {
//
//        if(par3Switch.isOn){
//            fairwayLabel.textColor = UIColor.lightGray
//            fairwaySwitch.isOn = false
//            fairwaySwitch.isEnabled = false
//        }
//        else {
//            fairwaySwitch.isEnabled = true
//            if(self.traitCollection.userInterfaceStyle == .dark) {
//                fairwayLabel.textColor = UIColor.white
//            }
//            else{
//                fairwayLabel.textColor = UIColor.black
//            }
//        }
//    }
    
    @IBAction func finishRound(_ sender: Any) {
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
        
        Variables.putts = Variables.putts + holePutts
        let rowIdx = scorePicker.selectedRow(inComponent: 0)
        
        holeScore = (pickerData[rowIdx] as NSString).doubleValue
        
        Variables.strokes = Variables.strokes + holeScore
        
        let holePar = (parSwitch.titleForSegment(at: parSwitch.selectedSegmentIndex)! as NSString).doubleValue
        Variables.par = Variables.par + holePar
        print(holePar)
        print(Variables.par)
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        try! realm.write {
            let round = Round()
            round.fairwaysHit = Int(Variables.fairwaysHit)
            round.totalHoles = Int(Variables.totalHoles)
            round.putts = Int(Variables.putts)
            round.greensHit = Int(Variables.greensHit)
            round.strokes = Int(Variables.strokes)
            round.roundName = Variables.roundName
            round.totalFairways = Variables.totalFairways
//            ADD IN PAR
//            round.par = Int(Variables.par)
            realm.add(round)

            
            //round.totalFairways = Variables.
        }
    }
    


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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

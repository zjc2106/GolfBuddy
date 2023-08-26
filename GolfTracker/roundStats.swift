//
//  FourthViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/9/22.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreLabelNoChange: UILabel!
    @IBOutlet weak var puttLabel: UILabel!
    @IBOutlet weak var puttLabelNoChange: UILabel!
    @IBOutlet weak var fairwayLabel: UILabel!
    @IBOutlet weak var fairwayLabelNoChange: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var greenLabelNoChange: UILabel!
    @IBOutlet weak var newRoundBut: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set IBOutlets up
        let toPar = Int(Variables.strokes)-Int(Variables.par)
        if (toPar == 0){
            scoreLabel.text = "\(Int(Variables.strokes)) (E)"
        }
        else if (toPar > 0) {
            scoreLabel.text = "\(Int(Variables.strokes)) (+\(toPar))"
        }
        else{
            scoreLabel.text = "\(Int(Variables.strokes)) (\(toPar))"
        }
        puttLabel.text = "\(Int(Variables.putts))"
        fairwayLabel.text = "\(Int(Variables.fairwaysHit))/\(Variables.totalFairways)"
        greenLabel.text =
            "\(Int(Variables.greensHit))/\(Variables.totalHoles)"

    }
}

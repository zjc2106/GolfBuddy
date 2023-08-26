//
//  lifetimeStats.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/2/23.
//

import UIKit
import RealmSwift

class lifetimeStats: UIViewController {
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()


        var totalPutts = 0
        var totalHoles = 0
        var fairsHit = 0
        var totalFairways = 0
        var greensHit = 0
        var scoreList = [Int]()
        let roundList = realm.objects(Round.self)
        
        // no rounds in database
        if (roundList.count == 0){
            putts.text = "0"
            fairways.text = "0"
            greens.text = "0"
            handicap.text = "0"
        }
        else{
            // aggregates all round stats
            for round in roundList{
                totalPutts += (round.putts ?? 0)
                totalHoles += (round.totalHoles ?? 0)
                fairsHit += (round.fairwaysHit ?? 0)
                totalFairways += (round.totalFairways ?? 0)
                greensHit += (round.greensHit ?? 0)
                scoreList.append((round.strokes ?? 1000)-(round.par ?? 72))
            }
            let avgPutts=Float(totalPutts)/Float(totalHoles)
            let avgFairs=Float(fairsHit)/Float(totalFairways)*100
            let avgGreens=Float(greensHit)/Float(totalHoles)*100
            let fHandi = calcHandi(scoreList: scoreList)
            // Converts string to one sigfig
            putts.text = String(format: "%.1f", avgPutts)
            fairways.text = String(format: "%.1f", avgFairs) + "%"
            greens.text = String(format: "%.1f", avgGreens) + "%"
            handicap.text = String(format: "%.1f", fHandi)
        }
    }
    
    @IBOutlet weak var handicap: UILabel!
    @IBOutlet weak var fairways: UILabel!
    @IBOutlet weak var putts: UILabel!
    @IBOutlet weak var greens: UILabel!
    
    // function to calculate handicap
    func calcHandi(scoreList: [Int]) -> Float {
        let count = scoreList.count
        if (count > 8) {
            let newList = scoreList.sorted()[0...7]
            return Float(newList.reduce(0, +))/Float(count)
        }
        else {
            return Float(scoreList.reduce(0, +))/Float(count)
        }
    }
}

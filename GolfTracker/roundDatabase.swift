//
//  FifthViewController.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/20/22.
//

import UIKit
import RealmSwift

class FifthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roundTable: UITableView!
    
    let realm = try! Realm()
    var roundCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTable.delegate = self
        roundTable.dataSource = self
    }
    
    // finds number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let roundList = realm.objects(Round.self)
        return roundList.count
    }
    
    // gets info from database when row selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roundList = realm.objects(Round.self)
        roundTable.deselectRow(at: indexPath, animated: true)
        let selectedRound = roundList[indexPath.row]
        Variables.totalFairways = selectedRound.totalFairways ?? -1
        Variables.strokes = Double(selectedRound.strokes ?? -1)
        Variables.greensHit = Double(selectedRound.greensHit ?? -1)
        Variables.putts = Double(selectedRound.putts ?? -1)
        Variables.totalHoles = selectedRound.totalHoles ?? -1
        Variables.fairwaysHit = Double(selectedRound.fairwaysHit ?? -1)
        Variables.par = Double(selectedRound.par ?? -1)
        performSegue(withIdentifier: "roundSegue", sender: self)
    }
    
    // sets up cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let roundList = realm.objects(Round.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor(rgb: 0x146736)
        let label = UILabel(frame: CGRect(x:0, y:0, width:354, height:50))
        let testRoundName = roundList[indexPath.row].roundName ?? "<no-name>"
        let roundDate = roundList[indexPath.row].date ?? "old version"
        let roundHoles = roundList[indexPath.row].totalHoles
        
        label.numberOfLines = 1
        label.text = "\(roundHoles ?? 18) holes at \(testRoundName) on \(roundDate)"
        cell.addSubview(label)
        label.textColor = UIColor(rgb: 0xCC9966)
        label.font = UIFont(name: "HiraginoSans-W6", size: 17)
        label.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    
    // allows delete
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // delete helper function
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            let roundList = self.realm.objects(Round.self)
            try! self.realm.write {
                self.realm.delete(roundList[indexPath.row])
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
            }
            completionHandler(true)
        }
        
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    // height for each row-- automatic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

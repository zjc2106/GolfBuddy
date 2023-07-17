//
//  Round.swift
//  GolfTracker
//
//  Created by Zac Coeur on 8/10/22.
//

import Foundation
import RealmSwift

class Round: Object {
    @Persisted var roundName: String?
    @Persisted var totalHoles: Int?
    @Persisted var strokes: Int?
    @Persisted var putts: Int?
    @Persisted var greensHit: Int?
    @Persisted var fairwaysHit: Int?
    @Persisted var totalFairways: Int?
    @Persisted var date: Date?
//    @Persisted var par: Int?
}

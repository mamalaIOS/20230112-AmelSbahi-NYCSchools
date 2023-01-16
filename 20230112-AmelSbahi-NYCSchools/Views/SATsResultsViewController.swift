//  Created by Amel on 12/01/2023.
//

import UIKit

class SATsResultsViewController: UIViewController {
    
    var school: NYCSchoolSats?

    @IBOutlet weak var schooName: UILabel!
    @IBOutlet weak var numberOfSatTest: UILabel!
    @IBOutlet weak var satCriticalReading: UILabel!
    @IBOutlet weak var satMathAvgScore: UILabel!
    @IBOutlet weak var satWritingAvgScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfSatTest.text = "Number of Sat Test:  ".uppercased() + (school?.num_of_sat_test_takers ?? "N/A")
        satCriticalReading.text = "Sat Critical Reading:  ".uppercased() + (school?.sat_critical_reading_avg_score ?? "N/A")
        satMathAvgScore.text = "Sat Math Avg Score:  ".uppercased() + (school?.sat_math_avg_score ?? "N/A")
        satWritingAvgScore.text = "Sat Writing Avg Score:  ".uppercased() + (school?.sat_writing_avg_score ?? "N/A")
    }

}

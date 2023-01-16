//  Created by Amel on 12/01/2023.
//

import Foundation
import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    var school: NYCSchool?
    private var viewModel:NYCSchoolSatsResultViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = school?.school_name
        label2.text = "Total Student:  ".uppercased() + (school?.total_students ?? "")
        label3.text = "City:  ".uppercased() + (school?.city ?? "")
        label4.text = "Sports:  ".uppercased() + (school?.school_sports ?? "")
        label5.text = "Program:  ".uppercased() + (school?.program1 ?? "")
        label6.text = "Overview:  ".uppercased() + (school?.overview_paragraph ?? "")
        
        viewModel = NYCSchoolSatsResultViewModel(apiManager: RealAPIManager())
        if let dbn = school?.dbn {
            viewModel.fetchSatsResults(dbn: dbn)
        }
    }

    @IBAction func getSatsResultsButtonTapped(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SATsResultsViewController {
            if viewModel.satsCount != 0 {
                destination.school = viewModel.getSats(index: 0)
            }
        }
    }
}



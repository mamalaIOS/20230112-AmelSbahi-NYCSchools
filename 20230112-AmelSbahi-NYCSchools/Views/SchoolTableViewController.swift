//  Created by Amel on 12/01/2023.
//

import UIKit

protocol ListViewModelAction: AnyObject {
    func refreshUI()
}

class SchoolTableViewController: UIViewController {

    @IBOutlet weak var schoolTableView: UITableView!
    
    private var viewModel:NYCSchoolViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        schoolTableView.dataSource = self
        schoolTableView.delegate = self
        viewModel = NYCSchoolViewModel(apiManager: RealAPIManager(), actionDelegate: self)
        viewModel.fetchSchools()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SchoolDetailViewController {
            destination.school = viewModel.getSchool(index: (schoolTableView.indexPathForSelectedRow?.row)!)
        }
    }
}

extension SchoolTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schoolsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SchoolTableViewCell = schoolTableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCellID") as!
        SchoolTableViewCell
        let school = viewModel.getSchool(index: indexPath.row)
        
        cell.setData(school: school)
        return cell
    }
}

extension SchoolTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SchoolTableViewController: ListViewModelAction {
    
    func refreshUI() {
        DispatchQueue.main.async {
            self.schoolTableView?.reloadData()
        }
    }
}

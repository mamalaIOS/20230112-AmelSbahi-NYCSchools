//  Created by Amel on 12/01/2023.
//

import Foundation

protocol NYCSchoolViewModelInput {
    func fetchSchools()
}

protocol NYCSchoolViewModelOutput {
    var schoolsCount: Int {get}
    func getSchool(index: Int)-> NYCSchool
}

final class NYCSchoolViewModel: NYCSchoolViewModelInput, NYCSchoolViewModelOutput  {

    private var schools = [NYCSchool]()
    private var apiManager: APIManager
    

    private weak var actionDelegate: ListViewModelAction?

    var schoolsCount: Int {
        return schools.count
    }

    init(apiManager: APIManager, actionDelegate: ListViewModelAction) {
        self.apiManager = apiManager
        self.actionDelegate = actionDelegate
    }

    func fetchSchools() {
        apiManager.call(url: APIEndpoints.schools, decoding: [NYCSchool].self) {[weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools
                self?.actionDelegate?.refreshUI()
            case .failure(_):
                self?.schools = []
            }
        }
    }

    func getSchool(index: Int)-> NYCSchool {
        return schools[index]
    }
    
}



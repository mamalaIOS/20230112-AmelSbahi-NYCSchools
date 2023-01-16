//  Created by Amel on 12/01/2023.
//

import Foundation

protocol NYCSchoolSatsResultViewModelInput {
    func fetchSatsResults(dbn: String)
}

protocol NYCSchoolSatsResultsViewModelOutput {
    func getSats(index: Int) -> NYCSchoolSats
    var satsCount: Int {get}
}

final class NYCSchoolSatsResultViewModel: NYCSchoolSatsResultViewModelInput, NYCSchoolSatsResultsViewModelOutput  {
    
    private var schoolSats = [NYCSchoolSats]()
    private var apiManager: APIManager

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func fetchSatsResults(dbn: String) {
        apiManager.call(url: URL(string: APIEndpoints.schoolSats + dbn), decoding: [NYCSchoolSats].self) {[weak self] result in
            switch result {
            case .success(let schoolSats):
                self?.schoolSats = schoolSats
            case .failure(_):
                self?.schoolSats = []
            }
        }
    }
    
    var satsCount: Int {
        return schoolSats.count
    }
    
    func getSats(index: Int) -> NYCSchoolSats {
        return schoolSats[index]
    }
    
}

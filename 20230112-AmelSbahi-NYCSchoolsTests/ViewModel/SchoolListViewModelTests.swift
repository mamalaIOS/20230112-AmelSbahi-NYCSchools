//  Created by Amel on 12/01/2023.
//

import XCTest
@testable import _0230112_AmelSbahi_NYCSchools

class SchoolListViewModelTests: XCTestCase {

    var viewModel: NYCSchoolViewModel!
    var apiManager: SchoolsMockAPIManager!
    var vc = SchoolTableViewController()
    
    override func setUpWithError() throws {
        apiManager = SchoolsMockAPIManager()
        viewModel = NYCSchoolViewModel(apiManager: apiManager, actionDelegate: vc)
    }

    override func tearDownWithError() throws {
  
    }
    
    
    func testGetSchoolsSuccess() {
        
        viewModel.fetchSchools()
                
        XCTAssertEqual(viewModel.schoolsCount, 3)
        
       let school =  viewModel.getSchool(index: 0)
        XCTAssertEqual(school.school_name, "Clinton School Writers & Artists, M.S. 260")
        XCTAssertEqual(school.phone_number,  "212-524-4360")
    }
    
    func testGetSchoolsFailure() {
        
        apiManager.isApiSuccessFull = false
        
        viewModel.fetchSchools()
        
        XCTAssertEqual(viewModel.schoolsCount, 0)
    
    }
    
   
}

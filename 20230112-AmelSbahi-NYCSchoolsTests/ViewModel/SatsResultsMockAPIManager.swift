//  Created by Amel on 12/01/2023.
//

import Foundation
@testable import _0230112_AmelSbahi_NYCSchools

class SatsResultsMockAPIManager: APIManager {
    
    var isApiSuccessFull = true
    
    func call<T>(url: URL?, decoding: T.Type, completion: @escaping (Result<T, RequestErrors>) -> ()) where T : Decodable, T : Encodable {
        
        if isApiSuccessFull {
            completion(.success(NYCSchoolSats.mockedsatsResultsResponse as! T))
        }else {
            completion(.failure(RequestErrors.badData))

        }
    }
    
}



extension NYCSchoolSats {
    
    static var mockedsatsResultsResponse = [NYCSchoolSats(school_name: "LIBERATION DIPLOMA PLUS", num_of_sat_test_takers: "10", sat_critical_reading_avg_score: "411", sat_math_avg_score: "369", sat_writing_avg_score: "373")]
}

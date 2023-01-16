//  Created by Amel on 12/01/2023.
//

import Foundation
@testable import _0230112_AmelSbahi_NYCSchools

class MockURLSession: URLSession {
    
    let mockDataTask =  MockURLSessionDataTask()
    
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        mockDataTask.completionHandler = completionHandler
        return mockDataTask
    }
  
    func enqueueResponse(urlResponse: HTTPURLResponse, error: RequestErrors?) {
        mockDataTask.urlResponse = urlResponse
        mockDataTask.serviceError = error
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var  urlResponse: HTTPURLResponse!
    var  serviceError: RequestErrors!
    override func resume() {
        completionHandler!("success".data(using:.utf8), urlResponse, serviceError)
    }
}



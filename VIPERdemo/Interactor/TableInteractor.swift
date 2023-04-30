//
//  TableInteractor.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation

//Object
//Protocol
//Ref to Presenter

protocol AnyInteractor {
    
    var presenter: AnyPresenter? { get set }
    
    func getUsersApiCall()
}

class TableInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsersApiCall() {
        
        
        let request = APIRequest()
        print("Request Started.")
        request.genericApiCall(urlStr: APIs.firstApi, type: .GET) { result in
            self.presenter?.showUsers(with: result)
            print("Request Ended.")
        }
        
    }
    
    //    func getUsersApiCall() {
    //
    //        var dispatchGroup = DispatchSemaphore(value: 1)
    //
    //        dispatchGroup.wait()
    //        var dispatchQu1 = DispatchQueue(label: "com.ankush")
    //        dispatchQu1.async {
    //            let request = APIRequest()
    //            print("First Request Started.")
    //            request.genericApiCall(urlStr: APIs.firstApi, type: .GET) { result in
    //                self.presenter?.showUsers(with: result)
    //                print("First Request Ended.")
    //                dispatchGroup.signal()
    //            }
    //        }
    //        dispatchGroup.wait()
    //
    //        var dispatchQu2 = DispatchQueue(label: "com.ankush")
    //        dispatchQu2.async {
    //            let request = APIRequest()
    //            print("Second Request Started.")
    //            request.genericApiCall(urlStr: APIs.firstApi, type: .GET) { result in
    //                self.presenter?.showUsers(with: result)
    //                print("Second Request Ended.")
    //                dispatchGroup.signal()
    //            }
    //        }
    //    }
    
    
    
    //    func getUsersApiCall() {
    //
    //        var dispatchGroup = DispatchGroup()
    //
    //        dispatchGroup.enter()
    //        var dispatchQu1 = DispatchQueue(label: "com.ankush")
    //        dispatchQu1.async {
    //            let request = APIRequest()
    //            print("First Request Started.")
    //            request.genericApiCall(urlStr: APIs.firstApi, type: .GET) { result in
    //                self.presenter?.showUsers(with: result)
    //                print("First Request Ended.")
    //                dispatchGroup.leave()
    //            }
    //
    //        }
    //        dispatchGroup.enter()
    //
    //        var dispatchQu2 = DispatchQueue(label: "com.ankush")
    //        dispatchQu2.async {
    //            let request = APIRequest()
    //            print("Second Request Started.")
    //            request.genericApiCall(urlStr: APIs.firstApi, type: .GET) { result in
    //                self.presenter?.showUsers(with: result)
    //                print("Second Request Ended.")
    //                dispatchGroup.leave()
    //            }
    //
    //        }
    //
    //        dispatchGroup.notify(queue: DispatchQueue.main, execute: {
    //
    //            print("Finished all requests.")
    //        })
    //    }
    
    
    
}

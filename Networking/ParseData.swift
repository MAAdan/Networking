//
//  ParseData.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 26/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation

protocol MappedObject {
    
}

protocol MapperProtocol {
    func map(dictionary: Any) -> MappedObject
}

class ParseData<T> {
    
    var dataMapper: MapperProtocol
    
    init(dataMapper: MapperProtocol) {
        self.dataMapper = dataMapper
    }
    
    func parse(data: Data) -> T? {
        
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dataMapped = dataMapper.map(dictionary: dictionary) as? T {
                return dataMapped
            }
        } catch {
            
        }
        
        return nil
    }
}

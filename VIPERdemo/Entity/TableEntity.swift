//
//  TableEntity.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation

//Models - Entity

struct TableEntity: Codable {
    let status: Bool?
    var data: [InnerEntity]?
}


struct InnerEntity: Codable {
    let parentID: Int?
    let body: String?
    let order: Int?
    let slug: String?
    let id: Int?
    let createdBy, updatedBy: Int?
    let status: Int?
    let title: String?
    let children: [InnerEntity]?

    //Custom variable for opening and collapsing
    var isCollapsed: Bool = true
    
    mutating func updateCollapsed (value: Bool) {
        isCollapsed = value
    }
    
    enum CodingKeys: String, CodingKey {
        case parentID = "parent_id"
        case body, order, slug, id
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case status, title, children
    }
}

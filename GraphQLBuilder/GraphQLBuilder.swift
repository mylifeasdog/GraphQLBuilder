//
//  GraphQLBuilder.swift
//  GraphQLBuilder
//
//  Created by Wipoo Shinsirikul on 1/11/17.
//  Copyright © 2017 Wipoo Shinsirikul. All rights reserved.
//

import Foundation

public enum GraphQLBuilder
{
    case field(String)
    case object(String?, [GraphQLBuilder])
    
    public static func query(rootKey: String? = "query", _ qs: [GraphQLBuilder]) -> GraphQLBuilder
    {
        return .object(rootKey, qs)
    }
    
    public func build() -> String
    {
        if case .field(let name) = self
        {
            return name
        }
        else if case .object(let name, let fields) = self
        {
            if let name = name
            {
                return name + "{" + fields.map { $0.build() }.joined(separator: ",") + "}"
            }
            else
            {
                return fields.map { $0.build() }.joined(separator: ",")
                
            }
        }
        else
        {
            return ""
        }
    }
}

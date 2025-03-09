//
//  UrgentBadge.swift
//  LeboncoinUIKit
//
//  Created by Tiago Silva on 09/03/2025.
//

import SwiftUI

public struct UrgentBadge: View {
    public init() {}
    
    public var body: some View {
        Text("URGENT")
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, spacing: .pt8)
            .padding(.vertical, spacing: .pt4)
            .background(Color.App.warning)
            .foregroundColor(.App.label)
            .cornerRadius(4)
    }
}

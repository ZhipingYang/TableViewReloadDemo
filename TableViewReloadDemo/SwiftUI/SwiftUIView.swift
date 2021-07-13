//
//  SwiftUIView.swift
//  TableViewReloadDemo
//
//  Created by Daniel Yang on 2021/7/12.
//

import SwiftUI

extension String: Identifiable {
    public var id: String {
        return self
    }
}

struct SwiftUIView: View {
    var names = (0...20).map { "name:\($0)" }

    var body: some View {
        NavigationView {
            List {
                ForEach(names) { name in
                    Text(name)
                }
            }
            .navigationBarTitle(Text("SwiftUI"))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

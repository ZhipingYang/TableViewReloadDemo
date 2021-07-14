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

struct Model: Identifiable {
    var title: String
    var subtitle: String
//    var id = UUID()
    var id: String { title + subtitle }
}

struct RCBarButtionItems: View {
    var update:(()->Void)
    var add:(()->Void)

    var body: some View {
        print("RCBarButtionItems pre-draw")

        return HStack {
            Button("update", action: update)
            Button("Add", action: add)
        }
    }
}

struct SwiftUIView: View {
    @State var models = (0...3).map { Model(title: "title", subtitle: "subtitle:\($0)") }

    var body: some View {
        NavigationView {
            RCListView(models: $models)
                .navigationBarTitle(Text("SwiftUI"))
                .navigationBarItems(trailing: RCBarButtionItems.init(update: {
                    models[0].subtitle = randomStr()
//                    models[0].id = UUID()
                    print("update action")
                }, add: {
                    let new = Model(title: "new", subtitle: "new subtitle:\(models.count)")
                    models.insert(new, at: Int.random(in: 0...models.count))
                    print("add action")
                }))
        }
    }
}

struct RCListView: View {
    @Binding var models: [Model]

    var body: some View {
        print("RCListView pre-draw")
        return List {
            ForEach(models) { model in
                RCListCell(model: model)
            }
        }.animation(.easeInOut)
    }
}

struct RCListCell: View {
    var model: Model

    var body: some View {
        print("RCListView pre-draw")
        return VStack(alignment: .leading) {
            Text(model.title)
            Spacer()
            Text(model.subtitle)
                .foregroundColor(.gray)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

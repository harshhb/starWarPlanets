//
//  PlanetListView.swift
//  starWarPlanets
//
//  Created by Harshana Ekanayake on 2025-10-29.
//

import SwiftUI

struct PlanetListView: View {
    @StateObject private var vm = PlanetListViewModel(repository: PlanetRepository())
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView("Loading planets…")
                } else if let _ = vm.errorMessage {
                    VStack {
                        Text("An error occurred, please try again.").multilineTextAlignment(.center)
                            .font(.footnote)
                        Button("Retry") {
                            Task { await vm.load() }
                        }
                    }
                } else {
                    List {
                        ForEach(vm.filtered(searchText)) { planet in
                            NavigationLink(destination: PlanetDetailView(planet: planet)) {
                                PlanetListItemView(planet: planet)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Planets")
            .searchable(text: $searchText, prompt: "Search planets")
            .task {
                await vm.load()
            }
        }
    }}

#Preview {
    PlanetListView()
}

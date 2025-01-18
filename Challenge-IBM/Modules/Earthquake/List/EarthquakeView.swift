//
//  EarthquakeView.swift
//  Challenge-IBM
//
//  Created by Yonny on 16/01/25.
//

import SwiftUI

struct EarthquakeView: View {
    
    // MARK: - PropertyWrappers
    @ObservedObject private var viewModel: EarthquakeVM

    init(viewModel: EarthquakeVM = EarthquakeVM()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            searchTextField
            listEarthquakes
            actionButton
        }
        .alert(isPresented: $viewModel.displayError) {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Error desconocido"), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            viewModel.fetchEarthquake()
        }
    }
    
    var searchTextField: some View {
        HStack {
            TextField("Buscar terremoto x titulo...", text: $viewModel.searchText)
                .padding(15)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 27)
        .padding(.top, 10)
    }
    
    var listEarthquakes: some View {
        List {
            ForEach(viewModel.earthquake, id: \.id) { earthquake in
                EarthquakeCell(earthquak: earthquake)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        viewModel.goToEarthquakeDetail(eventID: earthquake.id)
                    }
            }
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(1.5)
                        Text("Cargando más terremotos...")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .transition(.opacity)
            } else {
                Color.clear
                    .frame(height: 1)
                    .onAppear {
                        viewModel.fetchEarthquake()
                    }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
     var actionButton: some View {
         Button(
             action: {
                 viewModel.logOut()
             },
             label: {
                 Text("Cerrar Session")
                     .font(.system(size: 16, weight: .bold))
                     .frame(maxWidth: .greatestFiniteMagnitude, alignment: .center)
                     .foregroundColor(Color("White"))
                     .padding(15)
                     .frame(maxWidth: .greatestFiniteMagnitude)
                     .background {
                         RoundedRectangle(cornerRadius: 5)
                             .foregroundColor(Color("Black"))
                     }
                     .padding(.horizontal, 25)
                     .padding(.vertical, 10)
             }
         )
     }
    
}

#Preview {
    EarthquakeView()
}

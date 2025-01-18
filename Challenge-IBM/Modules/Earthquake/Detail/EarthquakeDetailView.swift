//
//  EarthquakeDetailView.swift
//  Challenge-IBM
//
//  Created by Yonny on 18/01/25.
//

import SwiftUI

struct EarthquakeDetailView: View {
    
    // MARK: - PropertyWrappers
    @ObservedObject private var viewModel: EarthquakeDetailVM
    
    init(
        viewModel: EarthquakeDetailVM =
        EarthquakeDetailVM(eventID: "ci40842527")
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            navigationBar
            ScrollView {
                VStack(spacing: 24) {
                    titleSection
                    detailSection
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
        .toolbar(.hidden)
    }
    
    var titleSection: some View {
        VStack(spacing: 12) {
            Text(viewModel.earthquake?.properties.title ?? "Detalles del Terremoto")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 16)
            
            Text(viewModel.earthquake?.properties.place ?? "Ubicación desconocida")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 30)
    }
    
    var detailSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Detail(
                label: "Magnitud:",
                value: String(format: "%.2f", viewModel.earthquake?.properties.magnitude ?? 0.0),
                icon: "waveform.path.ecg"
            )
            
            Detail(
                label: "Profundidad:",
                value: "\(viewModel.earthquake?.geometry.coordinates.last ?? 0.0) km",
                icon: "arrow.down.to.line"
            )
            
            Detail(
                label: "Lugar:",
                value: viewModel.earthquake?.properties.place ?? "N/A",
                icon: "map"
            )
        }
    }
    
    
    var navigationBar: some View {
        ZStack {
            HStack {
                Button {
                    viewModel.popLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
            Text("Descripcion")
                .font(.title2)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 20)
        .frame(height: 58.0)
    }
    
}

struct Detail: View {
    
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    EarthquakeDetailView()
}

//
//  EarthquakeCell.swift
//  Challenge-IBM
//
//  Created by Yonny on 16/01/25.
//

import SwiftUI

struct EarthquakeCell: View {
    
    let earthquak: EarthquakeFeature
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
            DetailRow(label: "Magnitud:", value: String(format: "%.2f", earthquak.properties.magnitude))
            DetailRow(label: "Profundidad:", value: "\(earthquak.geometry.coordinates.last ?? 0.0) km")
            DetailRow(label: "Lugar:", value: earthquak.properties.place)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .cornerRadius(12)
          .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
          .padding(.horizontal)
    }

    var title: some View {
        Text(earthquak.properties.title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    
}

struct DetailRow: View {
    
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)

            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
    
}

#Preview {
    EarthquakeCell(
        earthquak: EarthquakeResponse.getStubEarthquakeResponse().features.first!
    )
}

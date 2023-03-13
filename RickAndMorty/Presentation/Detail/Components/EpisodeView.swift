import SwiftUI

struct EpisodeView: View {
    
    var episode: Episode
    
    var body: some View {
        HStack(alignment: .center) {
            Text(episode.episodeNumber)
                .foregroundColor(.green)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                )
            
            VStack(alignment: .leading) {
                Text(episode.name)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Color.black)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text(episode.airDate)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color.gray.opacity(0.8))
                    .fontWeight(.semibold)
            }
            
        }
        .padding(.bottom)
        
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView(episode: MockDetailView.mockEpisode(name: "Pilot de name is very colti"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

import SwiftUI

struct DetailView: View {
    
    var character: Character
    var episodes: [Episode]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                HeaderView(character: character)
                
                Text("Episodes")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .padding(.top, 20)
                    .padding(.bottom, 25)
                
                ForEach(episodes) { episode in
                    EpisodeView(episode: episode)
                }
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: MockDetailView.mockCharacter(),
                   episodes: [MockDetailView.mockEpisode()]
        )
    }
}

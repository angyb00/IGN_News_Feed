import Foundation

class VideosDataModel: ObservableObject {
    @Published private(set) var videos: [Video] = []
    @Published private(set) var isLoading = false

    private var request: APIRequest<VideoResources>?

    func loadVideos() {
        guard !isLoading else { return }
        isLoading = true
        let resource = VideoResources()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] videos in
            self?.videos = videos ?? []
            self?.isLoading = false
        }
    }
}

/// Different way of getting downloading data
// class getVideos: ObservableObject {
//    var url: String = "https://ign-apis.herokuapp.com/videos?startIndex=30&count=5"
//
//    @Published var video = videoRequest()
//
//    func getData() {
//        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [weak self] data, _, error in
//
//            guard let data = data, error == nil else {
//                print("error")
//                return
//            }
//            do {
//                let video = try JSONDecoder().decode(videoRequest.self, from: data)
//
//                DispatchQueue.main.async {
//                    self?.video = video
//                }
//            }
//            catch {
//                print("Failed to convert \(error)")
//            }
//        })
//        task.resume()
//    }
// }
//
// struct videoRequest: Codable {
//    var data: [video] = []
// }
//
// struct video: Codable, Hashable {
//    var contentId: String
//    var thumbnails: [videoThumbnail]
//    var metadata: videoMetadata
//    var assets: [Asset]
// }
//
// struct videoThumbnail: Codable, Hashable {
//    var url: String?
//    var size: String?
//    var height: Int?
//    var width: Int?
// }
//
// struct videoMetadata: Codable, Hashable {
//    var title: String
//    var description: String?
//    var publishDate: String
// }
//
// struct Asset: Codable, Hashable {
//    var url: String
//    var height: Int
//    var width: Int
// }

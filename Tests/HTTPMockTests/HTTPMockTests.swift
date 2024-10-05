import Foundation
import Testing
@testable import HTTPMock

@Test
func example() async throws {

//    HTTPMock.mock(.init(.path("path"), statusCode: 200, data: Data()))
//    HTTPMock.mock(.init(.request(URLRequest()), statusCode: 200, data: Data()))
//    HTTPMock.mock(.init(.domain("domain") && .path("path", statusCode: 200))
}
@Test
func request() async throws {
    var configuration = URLSessionConfiguration.ephemeral

    configuration.protocolClasses = [MockURLProtocol.self]

    let session = URLSession(configuration: configuration)

    let (data, response) = try await session.data(for: .init(url: #require(URL(string: "https://host.domain/path"))))

    #expect(data.count > 0)
}

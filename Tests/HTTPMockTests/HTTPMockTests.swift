import Foundation
import Testing
@testable import HTTPMock

@Test
func treeCombinations() async throws {

    let tree1 = .host("host") & .path("path") & .httpHeaders(["String": "String"])
    let tree2 = (.host("host") & .path("path")) & .httpHeaders(["String": "String"])
    let tree3 = .host("host") & (.path("path") & .httpHeaders(["String": "String"]))
    let tree4 = .host("host") & .host("host") & (.path("path") & .httpHeaders(["String": "String"]))
    let tree5 = (.host("host") & .host("host")) & (.path("path") & .httpHeaders(["String": "String"]))
    let tree6 = (.host("host") & .host("host")) & .path("path") & .httpHeaders(["String": "String"])

    #expect(tree1.nodes.count == 3)
    #expect(tree2.nodes.count == 3)
    #expect(tree3.nodes.count == 2)
    #expect(tree4.nodes.count == 3)
    #expect(tree5.nodes.count == 3)
    #expect(tree6.nodes.count == 4)
}
@Test
func basicMock() async throws {

    await HTTPMock.mock(.init(.path("/requestPath"), data: "abc".data(using: .utf8) ?? Data()))

    let configuration = URLSessionConfiguration.ephemeral

    configuration.protocolClasses = [MockURLProtocol.self]

    let session = URLSession(configuration: configuration)

    let url = try #require(URL(string: "https://host.domain/requestPath"))

    let (data, response) = try await session.data(for: .init(url: url))

    #expect(String(data: data, encoding: .utf8) == "abc")
    #expect(response.url == url)
}


//    HTTPMock.mock(.init(.path("path"), statusCode: 200, data: Data()))
//    HTTPMock.mock(.init(.request(URLRequest()), statusCode: 200, data: Data()))
//    HTTPMock.mock(.init(.domain("domain") && .path("path", statusCode: 200))
//    await HTTPMock.mock(.init(.path("path")))
//    await HTTPMock.mock(.init(.host("host") & .path("path"), statusCode: 404))
//    await HTTPMock.mock(.init(.host("host") & .path("path") & .httpHeaders(["String": "String"])))


/*
 HTTPMock.mock(urlRequest: URLRequest)
 HTTPMock.mock(_ filter: HTTPPattern...)

 HTTPMock.mock(.https, .get, .domain("domain.top"), .path("path"), .queryString("q=term"))
 NONO HTTPMock.mock(.https + .get + .domain("domain.top") + .path("path") + .queryString("q=term"))

 HTTPMock.mock(.https && .get && .domain("domain.top") && .path("path") && .queryString(name: "q", value: "term"))

 HTTPMock.mock(!.path("path"))

 HTTPMock.mock(.path("path") || !.path("path"))

 HTTPMock.mock(!.path(regex: "\d+"))
 */

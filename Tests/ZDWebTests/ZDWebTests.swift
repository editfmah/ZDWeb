import XCTest
@testable import ZDWeb

var server: WebServer? = nil

class TestPage: WebHTMLEndpoint {
    
    var scripts: [String] = ["https://kit.fontawesome.com/7c67e0b7bb.js"]
    
    var styles: [String] = []
    
    var meta: [String : String] = [:]
    
    
    var title: String = "Sample Page"
    
    func save(_ c: ZDWeb.WebRequestContext, data: ZDWeb.WebRequestData) -> (any ZDWeb.WebResponseObject)? {
        return HttpResponse.accepted
    }
    
    func delete(_ c: ZDWeb.WebRequestContext) -> (any ZDWeb.WebResponseObject)? {
        return nil
    }
    
    func raw(_ c: ZDWeb.WebRequestContext) -> (any ZDWeb.WebResponseObject)? {
        return nil
    }
    
    func fragment(_ c: ZDWeb.WebRequestContext, activity: ZDWeb.WebNavigationActivity, fragment: String) -> (any ZDWeb.WebResponseObject)? {
        return nil
    }
    
    var controller: String? = "test"
    
    static func register() {
        WebServer.registrations.append(TestPage())
    }
    
    var grants: [WebNavigationActivity : [String]] = [
        .Content : [],
        .Modify : [],
        .Save : [],
        .Delete : [],
        .New : [],
        .View : [],
        .Raw : []
    ]
    
    var method: String? = "page"
    
    var accessible: [AuthenticationStatus] = [.unauthenticated]
    
    var initialEndpoint: Bool = true
    
    var menuEntry: (primary: String, secondary: String?)? = ("Home",nil)
    
    func content(_ c: WebRequestContext) -> WebResponseObject? {
        
        c.WebApplicationView {
            // Example usage
            let navbar = Navbar(
                brandText: "MyBrand",
                brandImage: "https://via.placeholder.com/30",
                items: [
                    .item(title: "Home", url: "/", icon: .home),
                    .item(title: "Features", children: [
                        .item(title: "Feature 1", url: "/feature1"),
                        .item(title: "Feature 2", url: "/feature2")
                    ]),
                    .item(title: "Pricing", url: "/pricing"),
                    .item(title: "About", url: "/about", icon: .infoCircle, disabled: true)
                ],
                accessories: [
                    .search(placeholder: "Search...", url: "/search", showAlways: true)
                ]
            ).theme(.dark)

            // Apply background color
            navbar.background(.blue)

            HStack {
            
            Modal(ref: "myModal") {
                Text("This is a modal")
            }
            
            Button("Open Modal")
                .onClick([
                    .showModal(ref: "myModal", contentURL: "https://zestdeck.com")
                ])
            
            let testVar = WString("Should be this text")
                .name("testing_var")
                .onValueChange([
                    .random([
                        .foregroundColor(ref: "textobject",.red),
                        .foregroundColor(ref: "textobject",.blue),
                        .foregroundColor(ref: "textobject",.green)
                    ])
                ])
            let testChoice = WString("3").name("testing_choice")
            HStack {
                Text("sample")
            }.minHeight(100).margin(20).border(.leading, .purple, width: 5).background(.lightpurple)
                HStack {
                    Spacer()
                    VStack {
                        Form {
                            Text(testVar).font(.largeTitle).foreground(.black).ref("textobject")
                            TextField("This is a text field", binding: testVar).name("txt_field")
                            Picker(binding: testChoice) {
                                Text("Option - Blank").value("")
                                Text("Option 1").value("1")
                                Text("Option 2").value("2")
                                Text("Option 3").value("3")
                            }.name("picker-field")
                            
                            Picker(type: .segmented, binding: testVar) {
                                Option("First value", value: "first")
                                Option("Second value", value: "second")
                                Option("Third value", value: "third")
                            }
                            
                            Button("Save")
                                .type(.submit)
                                .style(.warning)
                                .enabled(testChoice, .isNotEmpty)
                                .onEnable(.setStyle(.primary))
                                .onDisable(.setStyle(.light))
                                .badge(style: .danger, text: "34")
                        }.method(.post)
                    }.width(500)
                    Spacer()
                    Button("Click me")
                        .onClick(
                            .post(url: "http://localhost:53100/test/page",
                                  values: [testVar, testChoice],
                                  onSuccessful: [.setStyle(.success),.navigate("https://www.google.co.uk")],
                                  onFailed: [.setStyle(.danger)]
                                 )
                        )
                        .hidden(testVar, .isEmpty)
                        .background(.toBottom, [.darkGrey,.lightGrey,.darkGrey])
                        .tooltip("This is a tooltip")
                    
                    Button("Show/Hide").onClick(.collapse(ref: "table-collapsible"))
                    VStack(.auto) {
                        Button("Popover").onClick(.popover(title: "Title", content: "Some content goes here"))
                    }
                    
                    Table {
                        TableHeader {
                            HeaderCell("Header 1")
                            HeaderCell("Header 2")
                            HeaderCell("Header 3")
                        }.background(.darkorange).foreground(.white).padding(10)
                        TableBody {
                            TableRow {
                                Cell("Row 1, Cell 1")
                                Cell("Row 1, Cell 2")
                                Cell("Row 1, Cell 3")
                            }
                            TableRow {
                                Cell("Row 2, Cell 1")
                                Cell("Row 2, Cell 2")
                                Cell("Row 2, Cell 3")
                            }
                            TableRow {
                                Cell("Row 3, Cell 1")
                                Cell("Row 3, Cell 2")
                                Cell("Row 3, Cell 3")
                            }
                        }
                    }.margin(20).ref("table-collapsible").collapsible()
                    
                    Carousel([
                        .item(title: "First", subtitle: "First Subtitle", body: {
                            Text("First Item")
                        }, indicator: {
                            Text("1")
                        }),
                        .item(title: "Second", subtitle: "Second Subtitle", body: {
                            Text("Second Item")
                        }),
                        .item(title: "Third", subtitle: "Third Subtitle", body: {
                            Text("Third Item")
                        }, indicator: {
                            Text("3")
                        }),
                        .item(title: "Fourth", subtitle: "Fourth Subtitle", body: {
                            Text("Fourth Item")
                        }),
                        .item(title: "Fifth", subtitle: "Fifth Subtitle", body: {
                            Text("Fifth Item")
                        }, indicator: {
                            Text("5")
                        })
                    ]).jumpTo(3).interval(1)
                    
                    Accordion([
                        .item(title: "First Item", body: {
                            Text("First Item Body")
                        }),
                        .item(title: "Second Item", body: {
                            Text("Second Item Body")
                        }),
                        .item(title: "Third Item", body: {
                            Text("Third Item Body")
                        })
                    ]).expandFirst(true)
                    
                    // Example usage
                    Dropdown("Test Button", items: [
                        .item(title: "Item 1", url: "https://zestdeck.com", icon: .addressBook),
                        .item(title: "Item 2", url: "https://zestdeck.com", icon: .alignLeft, disabled: true),
                        .item(title: "Item 3", url: "https://zestdeck.com"),
                        .separator,
                        .item(title: "Item 4", url: "https://zestdeck.com", icon: .addressCard)
                    ])
                    
                    Progress(bindTo: WInt(50), maxValue: 100, showLabel: true)
                        .striped(true)
                        .animated(true)
                        .color(.blue)
                    
                    // Example usage
                    let spinner = Spinner(type: .grow, size: .large, color: .red, label: "Please wait...")
                    
                }.maxWidth(600)
                
                
            }.background(.toBottom, [.white, .blue, .blue, .blue, .white])
        }
        
    }
    
    func view(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func modify(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
    func new(_ c: WebRequestContext) -> WebResponseObject? {
        return nil
    }
    
}

final class ZDWebTests: XCTestCase {
    
    func testGenericStacksAndObjects() throws {
        
        // register the endpoint
        TestPage.register()
        
        // create a webserver
        server = WebServer(port: 53100) { context in
            
        }
        
        NSWorkspace.shared.open(URL(string: "http://localhost:53100/test/page")!)
        
        let waiter = DispatchSemaphore(value: 0)
        waiter.wait()
        
    }

}

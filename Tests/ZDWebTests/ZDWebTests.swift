import XCTest
@testable import ZDWeb

var server: WebServer? = nil

class TestPage: WebHTMLEndpoint {
    
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
        
        c.html(language: "EN") {
            c.head {
                c.title("Test")
                c.meta(name: "viewport", content: "width=device-width, initial-scale=1")
                c.script(url: "https://code.jquery.com/jquery-3.7.1.slim.min.js")
                c.stylesheet(url: "https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css")
                c.script(url: "https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js")
            }
            c.view {
                // include minimum/mandatory bootstrap 5
                
                Modal(ref: "myModal") {
                    Text("This is a modal")
                }
                
                Button("Open Modal")
                    .onClick([
                        .showModal(ref: "myModal")
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
                            Button("Save")
                                .type(.submit)
                                .style(.warning)
                                .enabled(testChoice, .isNotEmpty)
                                .onEnable(.setStyle(.primary))
                                .onDisable(.setStyle(.light))
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
                }.background(.toBottom, [.white, .blue, .blue, .blue, .white])
            }
            c.compileBuilderScripts()
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
    
    //    @discardableResult
    //    func View(_ body: WebComposerClosure) -> String {
    //
    //        let server = WebServer(port: 53100) { context in
    //
    //        }
    //
    //        let context = WebRequestContext(navigation: WebNavigationPosition(), data: WebRequestData(HttpRequest()), service: server, request: HttpRequest())
    //
//            context.html(language: "EN") {
//                context.head {
//                    context.title("Test")
//                    context.meta(name: "viewport", content: "width=device-width, initial-scale=1")
//                    context.stylesheet(url: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css")
//                    context.script(url: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js")
//                }
//                context.view {
//                    // include minimum/mandatory bootstrap 5
//                    body()
//                }
//                context.compileBuilderScripts()
//            }
    //
    //
    //        return context.body
    //
    //    }
    
    func testGenericStacksAndObjects() throws {
        
        // register the endpoint
        TestPage.register()
        
        // create a webserver
        server = WebServer(port: 53100) { context in
            
        }
        
        //        let body = View {
//
//                    let testVar = WString("Should be this text")
//                    let testChoice = WString("")
//                    let hideEmptyString = WBool(false)
//                    let showHiddenPanel = WBool(false)
//
//                    HStack {
//                        Spacer()
//                        VStack {
//                            Form {
//                                Text("This is a form")
//                                TextField("This is a text field", binding: testVar)
//                                Picker(binding: testChoice) {
//                                    Text("Option 1").value("1")
//                                    Text("Option 2").value("2")
//                                    Text("Option 3").value("3")
//                                }
//                                Button("Click me")
//                            }.method(.post)
//                        }.width(500)
//                        Spacer()
//                    }
        
        //
        //
        //            HStack {
        //                Spacer()
        //                VStack {
        //
        //                    HStack {
        //                        Image(url: "https://static.zestdeck.com/assets/img/site-logo.png")
        //                            .width(200)
        //                            .margin([.top,.bottom], 30)
        //                        Spacer()
        //                    }
        //                    Link("ZestDeck", url: "https://www.zestdeck.com")
        //                        .font(.largeTitle)
        //                        .foreground(.black)
        //                        .margin(.bottom, 20)
        //                    Text(testVar).font(.largeTitle).foreground(.black)
        //                    hideEmptyString.condition(testVar, operator: .isNotEmpty)
        //
        //                    Text("Text is empty").font(.largeTitle).foreground(.black).hidden(hideEmptyString)
        //                    TextField("This is placeholder text", binding: testVar)
        //                        .margin(.bottom, 20)
        //
        //                    Picker(binding: testChoice) {
        //                        Text("Option 1").value("1")
        //                        Text("Option 2").value("2")
        //                        Text("Option 3").value("3")
        //                    }
        //
        //                    HStack {
        //                        Text("You have selected ").font(.normal).foreground(.black)
        //                        Text(testChoice).font(.normal).foreground(.red)
        //                        Spacer()
        //                    }.margin(.top, 5)
        //
        //                    HStack {
        //                        Spacer()
        //                        Toggle(binding: showHiddenPanel)
        //                        Text("Show/Hide").font(.normal).foreground(.black)
        //                    }
        //
        //                    HStack {
        //                        Text("This is the hidden section").hidden(showHiddenPanel, .isFalse)
        //                    }
        //
        //                    Button("Click me")
        //                        .background(.red)
        //                        .foreground(.white)
        //                        .id("this-is-my-id")
        //                        .margin(.bottom, 20)
        //                        .onClick(script: "alert('Hello');")
        //                }
        //                .margin(.top, 100)
        //                .background(.lightGrey)
        //                .border(.darkGrey, width: 1)
        //                .radius(10)
        //                .shadow(3)
        //                .width(500)
        //                Spacer()
        //            }.background(.transparent)
        //
        //            Scrollview {
        //                for i in 0...20 {
        //                    Image(url: "https://static.zestdeck.com/assets/img/site-logo.png")
        //                        .height(200)
        //                        .width(200)
        //                        .scaleToFit()
        //                        .shadow(4)
        //                        .radius(8)
        //                        .margin(10)
        //                        .padding(10)
        //                        .background(.lightGrey)
        //                        .onClick(script: "alert('Clicked index \(i)');")
        //                }
        //            }.margin(100)
        
        NSWorkspace.shared.open(URL(string: "http://localhost:53100/test/page")!)
        
        let waiter = DispatchSemaphore(value: 0)
        waiter.wait()
        
    }

}

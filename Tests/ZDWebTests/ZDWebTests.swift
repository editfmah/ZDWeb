import XCTest
@testable import ZDWeb

final class ZDWebTests: XCTestCase {
    
    @discardableResult
    func View(_ body: WebComposerClosure) -> String {
        
        let server = WebServer(port: 53100) { context in
            
        }
        
        let context = WebRequestContext(navigation: WebNavigationPosition(), data: WebRequestData(HttpRequest()), service: server, request: HttpRequest())
        
        context.html(language: "EN") {
            context.head {
                context.title("Test")
                context.meta(name: "viewport", content: "width=device-width, initial-scale=1")
                context.stylesheet(url: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css")
                context.script(url: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js")
            }
            context.view {
                // include minimum/mandatory bootstrap 5
                body()
            }
            context.compileBuilderScripts()
        }
        
        
        return context.body
        
    }
    
    func testGenericStacksAndObjects() throws {
        
        let body = View {
            
            let testVar = WString("Should be this text")
            let testChoice = WString("")
            let hideEmptyString = WBool(false)
            let showHiddenPanel = WBool(false)
            
            HStack {
                Spacer()
                VStack {
                    
                    HStack {
                        Image(url: "https://static.zestdeck.com/assets/img/site-logo.png")
                            .width(200)
                            .margin([.top,.bottom], 30)
                        Spacer()
                    }
                    Link("ZestDeck", url: "https://www.zestdeck.com")
                        .font(.largeTitle)
                        .foreground(.black)
                        .margin(.bottom, 20)
                    Text(testVar).font(.largeTitle).foreground(.black)
                    hideEmptyString.condition(testVar, operator: .isNotEmpty)
                    
                    Text("Text is empty").font(.largeTitle).foreground(.black).hidden(hideEmptyString)
                    TextField("This is placeholder text", binding: testVar)
                        .margin(.bottom, 20)
                    
                    Picker(binding: testChoice) {
                        Text("Option 1").value("1")
                        Text("Option 2").value("2")
                        Text("Option 3").value("3")
                    }
                    
                    HStack {
                        Text("You have selected ").font(.normal).foreground(.black)
                        Text(testChoice).font(.normal).foreground(.red)
                        Spacer()
                    }.margin(.top, 5)
                    
                    HStack {
                        Spacer()
                        Toggle(binding: showHiddenPanel)
                        Text("Show/Hide").font(.normal).foreground(.black)
                    }
                    
                    HStack {
                        Text("This is the hidden section").hidden(showHiddenPanel, .isFalse)
                    }
                    
                    Button("Click me")
                        .background(.red)
                        .foreground(.white)
                        .id("this-is-my-id")
                        .margin(.bottom, 20)
                        .onClick(script: "alert('Hello');")
                }
                .margin(.top, 100)
                .background(.lightGrey)
                .border(.darkGrey, width: 1)
                .radius(10)
                .shadow(3)
                .width(500)
                Spacer()
            }.background(.transparent)
            
            Scrollview {
                for i in 0...20 {
                    Image(url: "https://static.zestdeck.com/assets/img/site-logo.png")
                        .height(200)
                        .width(200)
                        .scaleToFit()
                        .shadow(4)
                        .radius(8)
                        .margin(10)
                        .padding(10)
                        .background(.lightGrey)
                        .onClick(script: "alert('Clicked index \(i)');")
                }
            }.margin(100)
            
        }
        
        try? body.write(toFile: "test-output.html", atomically: true, encoding: .utf8)
        NSWorkspace.shared.openFile("test-output.html")
        
    }
    
}

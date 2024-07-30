import Foundation

public enum ButtonGroupStyle: String {
    case primary, secondary, success, danger, warning, info, light, dark, link
}

public enum ButtonGroupItem {
    case item(title: String, binding: WBool, style: ButtonGroupStyle? = nil, icon: FontAwesomeIcon? = nil)
}

public enum ButtonGroupType: String {
    case checkbox
    case radio
}

public protocol ButtonGroupProperties: GenericProperties {
    @discardableResult
    func style(_ style: String) -> Self
}

public extension GenericProperties {
    @discardableResult
    func style(_ style: String) -> Self {
        addClass("btn-group")
        addClass("btn-group-\(style)")
        return self
    }
}

public class ButtonGroup: WebElement, ButtonGroupProperties {
    private var btnType: ButtonGroupType

    @discardableResult
    public init(btnType: ButtonGroupType, style: ButtonGroupStyle, items: [ButtonGroupItem]) {
        self.btnType = btnType
        super.init()

        let groupId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")

        declare("div", classList: "btn-group", id: groupId, attributes: ["role": "group", "aria-label": "Basic \(btnType.rawValue) toggle button group"]) {
            for item in items {
                switch item {
                case .item(let title, let binding, let itemStyle, let icon):
                    let inputId = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
                    let buttonStyle = itemStyle ?? style
                    let buttonClass = "btn btn-outline-\(buttonStyle.rawValue)"
                    let activeClass = binding.internalValue ? "btn-\(buttonStyle.rawValue)" : ""

                    switch btnType {
                    case .checkbox:
                        declareCheckbox(inputId: inputId, buttonStyle: buttonStyle, buttonClass: buttonClass, activeClass: activeClass, binding: binding, title: title, icon: icon)
                    case .radio:
                        declareRadio(inputId: inputId, groupId: groupId, buttonStyle: buttonStyle, buttonClass: buttonClass, activeClass: activeClass, binding: binding, title: title, icon: icon, items: items)
                    }
                }
            }
        }

        script("""
        document.addEventListener('DOMContentLoaded', function() {
            let buttonGroup = document.getElementById('\(groupId)');
            let buttons = buttonGroup.querySelectorAll('input[type="\(btnType.rawValue)"]');
            buttons.forEach(function(button) {
                let label = button.nextElementSibling;
                let buttonStyle = label.getAttribute('class').match(/btn-(outline-)?(\\w+)/)[2];
                if (button.checked) {
                    label.classList.add('btn-' + buttonStyle);
                    label.classList.remove('btn-outline-' + buttonStyle);
                } else {
                    label.classList.add('btn-outline-' + buttonStyle);
                    label.classList.remove('btn-' + buttonStyle);
                }
            });
        });
        """)
    }

    private func declareCheckbox(inputId: String, buttonStyle: ButtonGroupStyle, buttonClass: String, activeClass: String, binding: WBool, title: String, icon: FontAwesomeIcon?) {
        declare("input", classList: "btn-check", id: inputId, attributes: ["type": "checkbox", "autocomplete": "off"]) {
            if binding.internalValue {
                script("document.getElementById('\(inputId)').checked = true;")
            }
            script("""
                document.getElementById('\(inputId)').addEventListener('change', function() {
                    let label = this.nextElementSibling;
                    if (this.checked) {
                        label.classList.add('btn-\(buttonStyle.rawValue)');
                        label.classList.remove('btn-outline-\(buttonStyle.rawValue)');
                    } else {
                        label.classList.add('btn-outline-\(buttonStyle.rawValue)');
                        label.classList.remove('btn-\(buttonStyle.rawValue)');
                    }
                    \(binding.builderId) = this.checked;
                });
            """)
        }
        declare("label", classList: "btn \(buttonClass) \(activeClass)", id: inputId, attributes: ["for": inputId]) {
            if let icon = icon {
                Icon(icon)
            }
            context.text(title)
        }
    }

    private func declareRadio(inputId: String, groupId: String, buttonStyle: ButtonGroupStyle, buttonClass: String, activeClass: String, binding: WBool, title: String, icon: FontAwesomeIcon?, items: [ButtonGroupItem]) {
        declare("input", classList: "btn-check", id: inputId, attributes: ["type": "radio", "autocomplete": "off", "name": groupId]) {
            if binding.internalValue {
                script("document.getElementById('\(inputId)').checked = true;")
            }
            script("""
                document.getElementById('\(inputId)').addEventListener('change', function() {
                    let label = this.nextElementSibling;
                    if (this.checked) {
                        label.classList.add('btn-\(buttonStyle.rawValue)');
                        label.classList.remove('btn-outline-\(buttonStyle.rawValue)');
                    }
                    \(binding.builderId) = this.checked;

                    document.querySelectorAll('input[name="\(groupId)"]').forEach(function(el) {
                        if (el !== document.getElementById('\(inputId)')) {
                            el.checked = false;
                            el.nextElementSibling.classList.add('btn-outline-\(buttonStyle.rawValue)');
                            el.nextElementSibling.classList.remove('btn-\(buttonStyle.rawValue)');
                        }
                    });

                    \(items.map({ item in
                        if case let .item(_, otherBinding, _, _) = item, otherBinding !== binding {
                            return "\(otherBinding.builderId) = false;"
                        }
                        return ""
                    }).joined(separator: ""))
                });
            """)
        }
        declare("label", classList: "btn \(buttonClass) \(activeClass)", id: inputId, attributes: ["for": inputId]) {
            if let icon = icon {
                Icon(icon)
            }
            context.text(title)
        }
    }
}


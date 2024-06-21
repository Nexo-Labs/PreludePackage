//
//  SwiftUIHelpers.swift
//
//
//  Created by Rubén García on 14/9/23.
//

#if canImport(SwiftUI)
import SwiftUI

public extension View {
    func alert<A: View, T>(_ titleKey: LocalizedStringKey, has: Binding<T?>, @ViewBuilder actions: (T) -> A) -> some View {
        let isPresented = Binding(get: {
            return has.wrappedValue != nil
        }, set: { newValue in
            if !newValue {
                has.wrappedValue = nil
            }
        })
        return alert(titleKey, isPresented: isPresented, actions: {
            if let value = has.wrappedValue{
                actions(value)
            }
        })
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<Content: View, ContentElse: View>(
        _ condition: Bool,
        transform: (Self) -> Content,
        else: ((Self) -> ContentElse)
    ) -> some View {
        if condition {
            transform(self)
        } else {
            `else`(self)
        }
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension View {
    @ViewBuilder
    public func navigationDestination<Value, Destination: View>(
        unwrapping value: Binding<Value?>,
        @ViewBuilder destination: (Binding<Value>) -> Destination
    ) -> some View {
        self.navigationDestination(isPresented: value.isPresent()) {
            if let value = Binding(value) {
                destination(value)
            }
        }
    }
}

extension Binding {
    /// Creates a binding by projecting the current optional value to a boolean describing if it's
    /// non-`nil`.
    ///
    /// Writing `false` to the binding will `nil` out the base value. Writing `true` does nothing.
    ///
    /// - Returns: A binding to a boolean. Returns `true` if non-`nil`, otherwise `false`.
    public func isPresent<Wrapped>() -> Binding<Bool>
    where Value == Wrapped? {
        self._isPresent
    }
}

extension Optional {
    fileprivate var _isPresent: Bool {
        get { self != nil }
        set {
            guard !newValue else { return }
            self = nil
        }
    }
}


public extension URL {
    func open() {
#if os(iOS)
        UIApplication.shared.open(self)
#elseif os(macOS)
        NSWorkspace.shared.open(self)
#endif
    }
}
#endif

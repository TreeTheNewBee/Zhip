//
// Copyright 2019 Open Zesame
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under thexc License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

public struct AnyUpperbound {
    private let _withinBounds: (Any) throws -> Void
    init<L>(_ type: L.Type) where L: ExpressibleByAmount & Upperbound {
        self._withinBounds = {
            guard let value = $0 as? L.Magnitude else {
                fatalError("incorrect implementation")
            }
            guard value <= L.maxInQa else {
                throw AmountError<L>.tooLarge(max: L.max)
            }
            // Yes is within bounds
            return
        }
    }

    init<E>(_ type: E.Type) where E: ExpressibleByAmount & NoUpperbound {
        self._withinBounds = { ignoredValue in
            // no upper bound, do not throw, just return
            return
        }
    }

    public func throwErrorIfNotWithinBounds(_ value: Any) throws {
        return try _withinBounds(value)
    }
}

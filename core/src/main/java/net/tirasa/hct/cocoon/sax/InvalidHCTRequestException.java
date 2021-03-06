/*
 * Copyright (C) 2012 Tirasa
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package net.tirasa.hct.cocoon.sax;

import net.tirasa.hct.cocoon.sax.Constants.State;
import org.apache.cocoon.pipeline.ProcessingException;

public class InvalidHCTRequestException extends ProcessingException {

    private static final long serialVersionUID = -2067223060451792198L;

    public InvalidHCTRequestException(final String message) {
        super(message);
    }

    public InvalidHCTRequestException(final String element, final State state) {
        super("Invalid " + element + " in state " + state);
    }
}

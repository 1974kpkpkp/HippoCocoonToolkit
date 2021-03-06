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
package net.tirasa.hct.editor.widgets;

import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxFallbackLink;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.IModel;

public class AjaxLinkLabel extends Panel {

    private static final long serialVersionUID = 9220205802680557479L;

    /**
     *
     * @param id
     * @param model
     */
    public AjaxLinkLabel(final String id, final IModel model) {
        super(id, model);
        AjaxFallbackLink link = new AjaxFallbackLink("link") {

            private static final long serialVersionUID = -7978723352517770644L;

            @Override
            public void onClick(AjaxRequestTarget target) {
                AjaxLinkLabel.this.onClick(target);
            }
        };
        link.add(new Label("label", model));
        add(link);
    }

    /**
     *
     * @param target
     */
    protected void onClick(AjaxRequestTarget target) {
        return;
    }
}

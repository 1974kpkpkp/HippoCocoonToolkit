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
package net.tirasa.hct.editor.crumbs;

import org.apache.wicket.extensions.breadcrumb.IBreadCrumbModel;
import org.apache.wicket.extensions.breadcrumb.panel.BreadCrumbPanel;
import org.apache.wicket.markup.html.panel.FeedbackPanel;

public abstract class HCTBreadCrumbPanel
        extends BreadCrumbPanel implements IAdminParticipant {

    private static final long serialVersionUID = -1404469954351908816L;

    private FeedbackPanel feedback;

    public HCTBreadCrumbPanel(final String id,
            final IBreadCrumbModel breadCrumbModel) {
        super(id, breadCrumbModel);

        // add feedback panel to show errors
        feedback = new FeedbackPanel("feedback");
        feedback.setOutputMarkupId(true);
        add(feedback);
    }

    @Override
    public String getTitle() {
        return (String) getTitle(this).getObject();
    }

    /**
     * get the feedback panel, might be null
     *
     * @return the feedback panel or null if not set
     */
    public FeedbackPanel getFeedbackPanel() {
        return feedback;
    }
}

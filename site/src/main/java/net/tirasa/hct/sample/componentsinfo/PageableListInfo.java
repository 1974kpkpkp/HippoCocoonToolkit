package net.tirasa.hct.sample.componentsinfo;

import org.hippoecm.hst.core.parameters.Parameter;

public interface PageableListInfo extends GeneralListInfo {

    @Parameter(name = "pagesVisible", defaultValue="true", displayName = "Show pages")
    Boolean isPagesVisible();

}
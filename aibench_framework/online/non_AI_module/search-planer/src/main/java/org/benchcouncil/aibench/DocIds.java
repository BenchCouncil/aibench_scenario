package org.benchcouncil.aibench;

import java.util.List;

public class DocIds {
    private List<UserItem> instances;

    public DocIds(List<UserItem> instances) {
        this.instances = instances;
    }

    public List<UserItem> getInstances() {
        return instances;
    }

    public void setInstances(List<UserItem> instances) {
        this.instances = instances;
    }
}

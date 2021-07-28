package org.benchcouncil.aibench;

import java.io.Serializable;
import java.util.List;

public class Ratings implements Serializable {
    private List<Rating> predictions;

    public List<Rating> getPredictions() {
        return predictions;
    }

    public void setPredictions(List<Rating> predictions) {
        this.predictions = predictions;
    }
}

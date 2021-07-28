package org.benchcouncil.aibench;

import java.io.Serializable;
import java.util.List;

public class Rating implements Serializable {
    private int item_id;
    private List<Double> rating;

    public int getItem_id() {
        return item_id;
    }

    public void setItem_id(int item_id) {
        this.item_id = item_id;
    }

    public List<Double> getRating() {
        return rating;
    }

    public void setRating(List<Double> rating) {
        this.rating = rating;
    }
}

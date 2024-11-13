package domain;

import java.util.ArrayList;
import java.util.List;

public class Book {
    private String title;
    private List<Copy> copies = new ArrayList<>(); // Initialize copies list

    public Book(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public List<Copy> getCopies() {
        return copies;
    }

    public void addCopy(Copy copy) {
        copies.add(copy);
    }
}

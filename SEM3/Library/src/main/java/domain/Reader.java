// Reader.java
package domain;
import java.util.ArrayList;
import java.util.List;

public class Reader {
    private String name;
    private List<Copy> borrowedCopies;

    public Reader(String name) {
        this.name = name;
        this.borrowedCopies = new ArrayList<>();
    }

    public void borrowCopy(Copy copy) {
        borrowedCopies.add(copy);
        copy.loan();
    }

    public List<Copy> getBorrowedCopies() {
        return borrowedCopies;
    }

    public String getName() {
        return name;
    }
}

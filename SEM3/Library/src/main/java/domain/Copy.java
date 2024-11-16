package domain;

public class Copy {
    private Book book;
    private boolean isLoaned;

    public Copy(Book book) {
        this.book = book;
        this.isLoaned = false;
    }

    public boolean isAvailable() {
        return !isLoaned;
    }

    public void loan() {
        isLoaned = true;
    }

    public void returnCopy() {
        isLoaned = false;
    }

    public Book getBook() {
        return book;
    }
}

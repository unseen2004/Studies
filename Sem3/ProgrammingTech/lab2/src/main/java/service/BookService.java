package service;

import domain.Book;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

public class BookService {
    private Map<String, Book> bookCatalog = new HashMap<>();

    public Book addBook(String title) {
        return bookCatalog.computeIfAbsent(title, Book::new);
    }

    // Method to find a book by its title
    public Book findBookByTitle(String title) {
        return bookCatalog.get(title);
    }

    public List<Book> getAllBooks() {
        return new ArrayList<>(bookCatalog.values());
    }
}

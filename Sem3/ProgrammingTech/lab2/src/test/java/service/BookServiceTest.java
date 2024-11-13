package service;

import domain.Book;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

public class BookServiceTest {

    private BookService bookService;

    @BeforeEach
    public void setUp() {
        bookService = new BookService();
    }

    @Test
    public void testAddBook() {
        Book book = bookService.addBook("Effective Java");
        assertNotNull(book);
        assertEquals("Effective Java", book.getTitle());
    }

    @Test
    public void testFindBookByTitle() {
        bookService.addBook("Effective Java");
        Book book = bookService.findBookByTitle("Effective Java");
        assertNotNull(book);
        assertEquals("Effective Java", book.getTitle());
    }

    @Test
    public void testGetAllBooks() {
        bookService.addBook("Effective Java");
        bookService.addBook("Clean Code");
        List<Book> books = bookService.getAllBooks();
        assertEquals(2, books.size());
    }
}
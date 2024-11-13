package domain;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

public class BookTest {

    @Test
    public void testBookCreation() {
        Book book = new Book("Effective Java");
        assertEquals("Effective Java", book.getTitle());
        assertTrue(book.getCopies().isEmpty());
    }

    @Test
    public void testAddCopy() {
        Book book = new Book("Effective Java");
        Copy copy = new Copy(book); // Pass the book instance to the Copy constructor
        book.addCopy(copy);
        List<Copy> copies = book.getCopies();
        assertEquals(1, copies.size());
        assertEquals(copy, copies.get(0));
    }
}
// LibraryConsole.java
package console;

import domain.Book;
import domain.Copy;
import domain.Reader;
import service.BookService;
import service.ReaderService;
import service.LoanService;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class LibraryConsole {
    private BookService bookService = new BookService();
    private ReaderService readerService = new ReaderService();
    private LoanService loanService = new LoanService();

    public void start() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Library System");

        while (true) {
            System.out.println("\nOptions:\n1. Add Book\n2. Add Copy\n3. Register Reader\n4. Loan Book\n5. View All Books\n6. View All Readers\n7. View Loaned Books for Reader\n8. Exit");

            try {
                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline character after int input

                switch (choice) {
                    case 1 -> addBook(scanner);
                    case 2 -> addCopy(scanner);
                    case 3 -> registerReader(scanner);
                    case 4 -> loanBook(scanner);
                    case 5 -> viewAllBooks();
                    case 6 -> viewAllReaders();
                    case 7 -> viewLoanedBooksForReader(scanner); // New option
                    case 8 -> System.exit(0);
                    default -> System.out.println("Invalid choice.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Please enter a valid number.");
                scanner.nextLine(); // Clear invalid input
            }
        }
    }

    private void viewLoanedBooksForReader(Scanner scanner) {
        System.out.print("Enter reader's name: ");
        String readerName = scanner.nextLine();
        Reader reader = readerService.findReaderByName(readerName);

        if (reader == null) {
            System.out.println("Reader not found. Please register the reader first.");
            return;
        }

        System.out.println("Books loaned to " + reader.getName() + ":");
        List<Copy> loanedCopies = loanService.getLoanedBooksForReader(reader);

        if (loanedCopies.isEmpty()) {
            System.out.println("No books loaned.");
        } else {
            for (Copy copy : loanedCopies) {
                System.out.println("- " + copy.getBook().getTitle());
            }
        }
    }

    private void addBook(Scanner scanner) {
        System.out.print("Enter book title: ");
        String title = scanner.nextLine();
        Book book = bookService.addBook(title);
        System.out.println("Book added: " + book.getTitle());
    }

    private void addCopy(Scanner scanner) {
        System.out.print("Enter book title for copy: ");
        String title = scanner.nextLine();
        Book book = bookService.findBookByTitle(title);

        if (book != null) {
            Copy copy = new Copy(book);
            book.addCopy(copy);
            System.out.println("Copy added for book: " + book.getTitle());
        } else {
            System.out.println("Book not found. Please add the book first.");
        }
    }

    private void registerReader(Scanner scanner) {
        System.out.print("Enter reader's name: ");
        String name = scanner.nextLine();
        readerService.registerReader(name);
        System.out.println("Reader registered: " + name);
    }

    private void loanBook(Scanner scanner) {
        System.out.print("Enter reader's name: ");
        String readerName = scanner.nextLine();
        Reader reader = readerService.findReaderByName(readerName);

        if (reader == null) {
            System.out.println("Reader not found. Please register the reader first.");
            return;
        }

        System.out.print("Enter book title to loan: ");
        String bookTitle = scanner.nextLine();
        Book book = bookService.findBookByTitle(bookTitle);

        if (book != null && !book.getCopies().isEmpty()) {
            Copy copy = book.getCopies().stream().filter(Copy::isAvailable).findFirst().orElse(null);
            if (copy != null) {
                loanService.loanCopy(reader, copy);
                System.out.println("Book loaned to " + reader.getName());
            } else {
                System.out.println("No available copies.");
            }
        } else {
            System.out.println("Book not found.");
        }
    }

    private void viewAllBooks() {
        System.out.println("All Books:");
        for (Book book : bookService.getAllBooks()) {
            System.out.println("- " + book.getTitle());
        }
    }

    private void viewAllReaders() {
        System.out.println("All Registered Readers:");
        for (Reader reader : readerService.getAllReaders()) {
            System.out.println("- " + reader.getName());
        }
    }
}

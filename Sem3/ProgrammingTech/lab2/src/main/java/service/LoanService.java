package service;

import domain.Copy;
import domain.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LoanService {
    private Map<Reader, List<Copy>> loans = new HashMap<>();

    public void loanCopy(Reader reader, Copy copy) {
        loans.computeIfAbsent(reader, r -> new ArrayList<>()).add(copy);
        copy.loan();
    }

    // Return a list of loaned books for a reader, or an empty list if no loans exist
    public List<Copy> getLoanedBooksForReader(Reader reader) {
        return loans.getOrDefault(reader, new ArrayList<>());
    }

    public void returnCopy(Reader reader, Copy copy) {
        List<Copy> loanedCopies = loans.get(reader);
        if (loanedCopies != null) {
            loanedCopies.remove(copy);
            copy.returnCopy();
        }
    }
}

package service;
import domain.Reader;
import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

public class ReaderService {
    private Map<String, Reader> readers = new HashMap<>();

    public void registerReader(String name) {
        readers.putIfAbsent(name, new Reader(name));
    }

    public Reader findReaderByName(String name) {
        return readers.get(name);
    }

    public List<Reader> getAllReaders() {
        return new ArrayList<>(readers.values());
    }
}

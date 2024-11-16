#include "Figury.h"

int main(int argc, char* argv[]) {
    if (argc < 3) {
        cout << "Za mało danych" << endl;
        return 1;
    }

    string figura = argv[1];
    double arg1 = atof(argv[2]);

    try {
        if (figura == "o") {
            Kolo kolo(arg1);
            cout << kolo.nazwa() << endl;
            cout << "Pole: " << kolo.obliczPole() << endl;
            cout << "Obwód: " << kolo.obliczObwod() << endl;
        } else if (figura == "p") {
            Pieciokat pieciokat(arg1);
            cout << pieciokat.nazwa() << endl;
            cout << "Pole: " << pieciokat.obliczPole() << endl;
            cout << "Obwód: " << pieciokat.obliczObwod() << endl;
        } else if (figura == "s") {
            Szeciokat szeciokat(arg1);
            cout << szeciokat.nazwa() << endl;
            cout << "Pole: " << szeciokat.obliczPole() << endl;
            cout << "Obwód: " << szeciokat.obliczObwod() << endl;
        } else if (figura == "c") {
            if (argc < 7) {
                cout << "Za mało danych dla czworokąta" << endl;
                return 1;
            }
            double arg2 = atof(argv[3]);
            double arg3 = atof(argv[4]);
            double arg4 = atof(argv[5]);
            double kat = atof(argv[6]);

            if (arg1 == arg2 && arg2 == arg3 && arg3 == arg4) {
                if (kat == 90) {
                    Kwadrat kwadrat(arg1);
                    cout << kwadrat.nazwa() << endl;
                    cout << "Pole: " << kwadrat.obliczPole() << endl;
                    cout << "Obwód: " << kwadrat.obliczObwod() << endl;
                } else {
                    Romb romb(arg1, kat);
                    cout << romb.nazwa() << endl;
                    cout << "Pole: " << romb.obliczPole() << endl;
                    cout << "Obwód: " << romb.obliczObwod() << endl;
                }
            } else if (arg1 == arg2 && arg3 == arg4) {
                Prostokat prostokat(arg1, arg3);
                cout << prostokat.nazwa() << endl;
                cout << "Pole: " << prostokat.obliczPole() << endl;
                cout << "Obwód: " << prostokat.obliczObwod() << endl;
            } else {
                cout << "Zle wymiary boków" << endl;
            }
        } else {
            cout << "Złe dane" << endl;
        }
    } catch (exception& e) {
        cout << "Nieprawidłowe dane wejściowe" << endl;
    }

    return 0;
}

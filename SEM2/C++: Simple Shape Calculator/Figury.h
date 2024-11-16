#ifndef FIGURY_H
#define FIGURY_H

#include <cmath>
#include <iostream>
using namespace std;

class Figura {
public:
    virtual double obliczPole() = 0;
    virtual double obliczObwod() = 0;
    virtual string nazwa() = 0;
};

class Kolo : public Figura {
private:
    double promien;

public:
    Kolo(double promien) : promien(promien) {}

    double obliczPole() override {
        return M_PI * promien * promien;
    }

    double obliczObwod() override {
        return 2 * M_PI * promien;
    }

    string nazwa() override {
        return "Koło";
    }
};

class Pieciokat : public Figura {
private:
    double bok;

public:
    Pieciokat(double bok) : bok(bok) {}

    double obliczPole() override {
        return 0.25 * sqrt(5 * (5 + 2 * sqrt(5))) * bok * bok;
    }

    double obliczObwod() override {
        return 5 * bok;
    }

    string nazwa() override {
        return "Pięciokąt";
    }
};

class Szeciokat : public Figura {
private:
    double bok;

public:
    Szeciokat(double bok) : bok(bok) {}

    double obliczPole() override {
        return (3 * sqrt(3) / 2) * bok * bok;
    }

    double obliczObwod() override {
        return 6 * bok;
    }

    string nazwa() override {
        return "Szeciokąt";
    }
};

class Czworokat : public Figura {
protected:
    double bok1, bok2, bok3, bok4, kat;

public:
    Czworokat(double bok1, double bok2, double bok3, double bok4, double kat)
            : bok1(bok1), bok2(bok2), bok3(bok3), bok4(bok4), kat(kat) {}
};

class Kwadrat : public Czworokat {
public:
    Kwadrat(double bok) : Czworokat(bok, bok, bok, bok, 90) {}

    double obliczPole() override {
        return bok1 * bok1;
    }

    double obliczObwod() override {
        return 4 * bok1;
    }

    string nazwa() override {
        return "Kwadrat";
    }
};

class Prostokat : public Czworokat {
public:
    Prostokat(double bok1, double bok2) : Czworokat(bok1, bok1, bok2, bok2, 90) {}

    double obliczPole() override {
        return bok1 * bok2;
    }

    double obliczObwod() override {
        return 2 * bok1 + 2 * bok2;
    }

    string nazwa() override {
        return "Prostokąt";
    }
};

class Romb : public Czworokat {
public:
    Romb(double bok, double kat) : Czworokat(bok, bok, bok, bok, kat) {}

    double obliczPole() override {
        return bok1 * bok1 * sin(kat * M_PI / 180);
    }

    double obliczObwod() override {
        return 4 * bok1;
    }

    string nazwa() override {
        return "Romb";
    }
};

#endif // FIGURY_H

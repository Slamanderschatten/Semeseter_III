//
// Created on 09.10.2025.
//

#pragma once

#include <iostream>
#include <chrono>

namespace hs_sweg {

    using namespace std;

    class Person {
    private:
        string name;
        string vorname;
        string geburtsdatum;
        int alter;



    public:


    };



    class Kunde : public Person {
    private:
        int nr;
    };



    class Adresse {
        string ort;
        string plz;
        string strasse;
        string hausnummer;
    };



    class Drucken {
    private:
        Adresse* adresse;
        Kunde* kunde;
    };

} // hs_sweg

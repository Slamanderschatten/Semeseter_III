# SORS 
SORS steht für **S**imple **O**penGL **R**endering **S**ystem und realisiert ein möglichst einfaches, objektorientiertes OpenGL Rendering System auf Basis eines **E**ntity **C**omponent **S**ystem (ECS). SORS wurde mit dem Ziel entwickelt Einsteigern der Computergrafik einen möglichst hohen Lerneffekt zu bieten. Folgende Leitlinien haben die Entwicklung bestimmt:
- Möglichst einfacher Start
- Nichts (möglichst wenig) lernen, was nicht benötigt oder zumindest für Game Engineering sehr sinnvoll ist
- Wichtigstes Lernziel: Eine Grafik-API (hier OpenGL) für die Grafikpipeline kennen lernen
- Verständlichkeit des Codes ist wichtiger als Performance
- Objektorientierte Programmierung in aktuellem C++ (Smart pointer, etc.)
- Studierende des dritten Semesters GE können am Ende einer Einführungsvorlesung den Code für einen kompletten Durchlauf der Rasterpipeline verstehen
- Enge Orientierung an den Lernzielen für Computergrafik und Realtime Rendering auf Bachelor- und Masterniveau
- Möglichst wenig Abhängigkeiten von externen Bibliotheken, insbesondere, was die Lauffähigkeit anbelangt (keine Installation)
- Das Kennenlernen notwendiger, zusätzlich erforderlicher Elemente soll sinnvolle Inhalte haben, die auch im weiteren Studium/Berufsleben einen eigenen Wert haben

## Systemvoraussetzungen
- Aktueller C++ Compiler (C++ 20)
- Aktuelle Qt Version (getestet 6.5)
- Cmake-fähige IDE (getestet Qt Creator, MS VS 2022)

## Verwendete externe Systeme 
- [EnTT](https://github.com/skypjack/entt) als sehr (meist?) verbreitetes und z.B. in der Unreal verwendbares ECS
- [TinyOBJLoader](https://github.com/tinyobjloader/tinyobjloader) um interessante Objekte/Modelle, z.B. aus Blender laden zu können

## How to start
- git clone ...
- git submodule init
- git submodule update
- CMakeList.txt des Wurzelverzeichnisses in IDE öffnen und übersetzen
- Eines der Projekte im Ordner "examples" ausführen
- Alle Module und Klassen sind über Doxygen dokumentiert, also Dokumentation generieren mit doxyfile im Wurzelverzeichnis und dort oder auch direkt im Code, der die Dokumentation ebenfalls enthält nachsehen

## Designentscheidungen
- Verwendung von Qt für 
    - Window- und Inputhandling
    - Qt-Container und Mathematik-/Matrixklassen
    - OpenGL-Anbindung inklusive Convenience-Wrapper (z.B. für Vertex-Buffer u.ä.).
- Verwendung eines Entity-Component-System (ECS): Zwei wesentliche interessante Systeme sind aktuell unterwegs, FLECS und EnTT. Wegen der größeren Verbreitung, modernerem C++ und „header-only“ fiel die Wahl auf EnTT. Gründe:
    - ECS sind in Game Engines verbreitet, also zusätzlicher Lerneffekt für die Studierenden. Unity hat ein eigenes System, EnTT kann in Unreal verwendet werden.
- Weitere externe Bibliothek „TinyObjLoader“, um (interessantere) Modelle und Materialien zu laden, ebenfalls Header only. Diese Lib ist praktisch, aber aus Softwareentwicklungssicht nicht wegweisend und ebenfalls nicht lehrreich!
- Ausschließliche Verwendung von Smart Pointern (aus C++ std), kein new/delete.
- Einsatz von Objektorientierung, insbesondere Polymorphismus weniger ausgeprägt. Datenorientiertes Design, wo sinnvoll (ECS ist bis auf Ableitungen von GeometryBase frei von Polymorphismus):
    - ECS optimiert auf statischen Polymorphismus.
    - Statt dyn. Polymorphismus hauptsächlich/öfters Komposition sowie Dependency Injection über Interfaces (z.B. MoveController oder IgeometryImplementation).
    - Möglichst wenig RTTI, möglichst gar nicht in ECS (Ausnahme Ableitungen von GeometryBase).
    - Code ist immer frei von Warnungen übersetzbar.
- OpenGL States werden nie zurückgesetzt nach Draw-Calls, jeder Draw-Call muss seinen State selbst richtig (neu) setzen
- Die „Systems“ des ECS werden für jedes Modul vorzugsweise in einer Klasse namens „Modulnamesystems“ abgebildet, das ist aber kein Zwang, ggf. können Systems auch dort implementiert werden, wo sie am meisten Bezug haben

## Allgemeine Hinweise zur Programmierung mit SORS und Namenskonventionen

- Bis auf Geometry ist jeder dynamischer Polymorphismus außerhalb des ECS (z.B. alle Controller)
- ECS an sich hat keine Pointer Stability, d.h. Pointer auf Objekte, die im ECS gespeichert werden, können sich ändern
- Unterscheide immer auto &lRenderable = ECS.get von auto lRenderable = ECS.get! Zweiteres erlaubt keine Veränderung der Component!

### Namenskonventionen
- Möglichst wenige
- Grundsätzlich immer CamelCase
- Lokale Variaben beginnen mit „l“
- Parameter beginnen mit „p“
- Statische (Klassen-)Variablen beginnen mit „s“
- Klassennamen beginnen mit Großbuchstaben
- Englische Namenskonventionen für Code – Kommentare in deutsch, klingt komisch, ist aber pragmatisch!

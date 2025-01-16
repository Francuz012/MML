Kratko objašnjenje kako funkcioniše

    Box funkcija
        Imamo mm pojedinačnih reziduala fi(x)fi​(x).
        Ukupan cilj (objektivna funkcija) je zbir kvadrata tih reziduala:
        F(x)  =  12∑i=1m[fi(x)]2.
        F(x)=21​i=1∑m​[fi​(x)]2.
        Cilj je pronaći xx koji minimizuje ovu funkciju, idealno tako da bude 0 (što znači da su svi fi(x)fi​(x) jednak nuli).

    Gradijentni spust
        U svakoj iteraciji izračunava se gradijent ∇F(x)∇F(x).
        Pravac pretrage postavlja se kao negativni gradijent (−∇F−∇F), koji pokazuje u “nizbrdo” smeru objektivne funkcije.

    Metoda zlatnog preseka
        Nakon dobijanja smera pp, treba utvrditi koliki korak αα treba napraviti (tj. koliko ćemo se pomeriti duž tog smera).
        Metoda zlatnog preseka sužava interval mogućih αα dok se ne pronađe približno optimalna dužina koraka.

    Ažuriranje i ponavljanje
        Kada se odabere αα, kod ažurira x←x+α px←x+αp.
        Ovo se ponavlja sve dok gradijent ne postane dovoljno mali (kriterijum konvergencije) ili dok se ne dostigne maksimalni broj iteracija.

Kako se koristi

    Zadate početnu pretpostavku (npr. (0, 10, 5)(0,10,5)).
    Pozovete solver (koji obuhvata navedene korake).
    Solver vraća rešenje x∗x∗ (recimo, blizu (1, 10, 1)(1,10,1)) i veoma malu vrednost ciljne funkcije (blizu 0).
    To znači da ste pronašli tačku gde su svi reziduali fi(x)fi​(x) skoro jednaki nuli, čime je Box 3D funkcija praktično rešena.

(deffacts init
    (nap 1) (nap 2) (nap 3) (nap 4) (nap 5)
)

(defrule pupi 
    ;1. Sem a hétfőn boltokba került könyvet, sem a Csengő című önéletrajzot nem női szerkesztő dolgozta át. 
    ; hetfoi megjelenesu konyv = szerkezto (nem abafibea es nem paloskata)

    (nap ?REZSO)
    (nap ?IMRE&~?REZSO)
    (nap ?EDE&~?IMRE&~?REZSO)

    (nap ?HETFO&1)

    (nap ?CSENGO&~?HETFO)

    (and 
        (or (nap ?REZSO&?HETFO) (nap ?IMRE&?HETFO) (nap ?EDE&?HETFO)) 
        (or (nap ?REZSO&?CSENGO) (nap ?IMRE&?CSENGO) (nap ?EDE&?CSENGO))
    )

    ;2. Mind a két előbb említett mű kevesebbe kerül, mint az Abafi Bea által átszerkesztett könyv, ami egy nappal a Joszkin Ede keze munkáját dícsérő kiadvány előtt jelent meg. 

    (nap ?BEA&~?EDE&~?IMRE&~?REZSO)
    (nap ?TIZENOT)
    (nap ?TIZENHET&~?TIZENOT)
    (nap ?HUSZ&~?TIZENHET&~?TIZENOT)
    (nap ?HUSZONKETTO&~?HUSZ&~?TIZENHET&~?TIZENOT)
    (nap ?HUSZONHAROM&~?HUSZONKETTO&~?HUSZ&~?TIZENHET&~?TIZENOT)
    
    ; hetfoi konyv ara < abafibea konyv ara
    ; csengo konyv ara < abafibea konyv ara
    
    (nap ?BEA&~?HETFO&~?CSENGO)
    (nap ?BEA&~?TIZENOT&~?TIZENHET)
    (or (nap ?BEA&?HUSZ) (nap ?BEA&?HUSZONKETTO) (nap ?BEA&?HUSZONHAROM)) 

    (or 
        (and (nap ?BEA&?HUSZ)
            (or (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?TIZENHET))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?TIZENHET))))

        (and (nap ?BEA&?HUSZONKETTO)
            (or (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?TIZENHET))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?TIZENHET))
                
                (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?HUSZ))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?HUSZ))

                (and (nap ?HETFO&?TIZENHET ) (nap ?CSENGO&?HUSZ))
                (and (nap ?CSENGO&?TIZENHET ) (nap ?HETFO&?HUSZ))))

        (and (nap ?BEA&?HUSZONHAROM)
             (or (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?TIZENHET))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?TIZENHET))
                
                (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?HUSZ))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?HUSZ))

                (and (nap ?HETFO&?TIZENOT ) (nap ?CSENGO&?HUSZONKETTO))
                (and (nap ?CSENGO&?TIZENOT ) (nap ?HETFO&?HUSZONKETTO))
                
                
                (and (nap ?HETFO&?TIZENHET ) (nap ?CSENGO&?HUSZ))
                (and (nap ?CSENGO&?TIZENHET ) (nap ?HETFO&?HUSZ))

                (and (nap ?HETFO&?TIZENHET ) (nap ?CSENGO&?HUSZONKETTO))
                (and (nap ?CSENGO&?TIZENHET ) (nap ?HETFO&?HUSZONKETTO))
                
                
                (and (nap ?HETFO&?HUSZ ) (nap ?CSENGO&?HUSZONKETTO))
                (and (nap ?CSENGO&?HUSZ ) (nap ?HETFO&?HUSZONKETTO))))
    )
    

    ;abafi bea konyv -> nap = 1 - joszkinede konyv
    (test (= (- ?EDE ?BEA) 1))


    ;3. A Túl Mindenen drágább, mint a Dalos Rezső szerkesztése. 
    ; tulmindenen konyv ara > dalosrezso konyv ara 

    (nap ?TULMINDENEN&~?CSENGO)
    (nap ?TULMINDENEN&~?REZSO)
    (nap ?TULMINDENEN&~?TIZENOT)

    (or 
        (and (nap ?TULMINDENEN&?TIZENHET) (nap ?REZSO&?TIZENOT) )

        (and (nap ?TULMINDENEN&?HUSZ) 
            (or
                (nap ?REZSO&?TIZENOT)
                (nap ?REZSO&?TIZENHET)
            )
        )

        (and (nap ?TULMINDENEN&?HUSZONKETTO)
            (or
                (nap ?REZSO&?TIZENOT)
                (nap ?REZSO&?TIZENHET)
                (nap ?REZSO&?HUSZ)
            )
        )

        (and (nap ?TULMINDENEN&?HUSZONHAROM)
            (or
                (nap ?REZSO&?TIZENOT)
                (nap ?REZSO&?TIZENHET)
                (nap ?REZSO&?HUSZ)
                (nap ?REZSO&?HUSZONKETTO)
            )
        )
    )

    ;4. A Márányfejek-et csütörtök óta lehet kapni. 
    ; csutortok konyv = maranyfejek konyv
    (nap ?MARANYFEJEK&~?TULMINDENEN&~?CSENGO)
    (nap ?CSUTORTOK&~?HETFO&4)

    (nap ?MARANYFEJEK&?CSUTORTOK)


    ;5. Az 1700 forintos önéletrajzot Pálos Kata öntötte vésgő formába; ez a mű a már a Márányfejek előtt a boltokban volt. 
    ; 1700 forintos konyv = paloskata szerzo es hetfon vagy kedden jelent meg (szerda nem lehet mert az 1500 ft 6.)
    (nap ?KATA&~?BEA&~?EDE&~?IMRE&~?REZSO)

    (nap ?KATA&?TIZENHET)

    (test (< ?KATA ?MARANYFEJEK))


    ;6. A szerdai megjelenésű könyv volt az öt közül a legolcsóbb. 
    ; szerdai konyv =  ara (nem 1700 es nem 2000 es nem 2200 es nem 2350)
    (nap ?SZERDA&~?CSUTORTOK&~?HETFO&3)

    (nap ?SZERDA&?TIZENOT)


    ;7. A Dobos Torta ára 2350 forint. 
    ; dobostorta konyv = ara (nem 1500 es nem 1700 es nem 2000 es nem 2200)
    (nap ?DOBOSTORTA&~?MARANYFEJEK&~?TULMINDENEN&~?CSENGO)

    (nap ?DOBOSTORTA&?HUSZONHAROM)


    ;8. Gémes Imre a rock-sztár kéziratát szerkesztette át. 
    ; zenebona cimu konyv ) = szerkeszto (nem dalosrezso es nem joszkinede es nem paloskata es nem abafibea)
    (nap ?ZENEBONA&~?DOBOSTORTA&~?MARANYFEJEK&~?TULMINDENEN&~?CSENGO)

    (nap ?IMRE&?ZENEBONA)

    (nap ?KEDD&~?SZERDA&~?CSUTORTOK&~?HETFO&2)
    (nap ?PENTEK&~?KEDD&~?SZERDA&~?CSUTORTOK&~?HETFO&5)

    => 

    (assert (NAPOK: hetfo ?HETFO kedd ?KEDD szerda ?SZERDA csutortok ?CSUTORTOK pentek ?PENTEK))
    (assert (SZERZOK: DalosRezso ?REZSO GemesImre ?IMRE JoszkinEde ?EDE PalosKata ?KATA AbafiBea ?BEA))
    (assert (CIMEK: Csengo ?CSENGO TulMindenen ?TULMINDENEN Maranyfejek ?MARANYFEJEK DobosTorta ?DOBOSTORTA Zenebona ?ZENEBONA))
    (assert (ARAK: 1500ft ?TIZENOT 1700ft ?TIZENHET 2000ft ?HUSZ 2200ft ?HUSZONKETTO 2350ft ?HUSZONHAROM))
)

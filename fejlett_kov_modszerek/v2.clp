(deffacts init
    (nap hetfo) (nap kedd) (nap szerda) (nap csutortok) (nap pentek)
    (cimek csengo) (cimek dobostorta) (cimek maranyfejek) (cimek tulmindenen) (cimek zenebona)
    (szerkesztok abafibea) (szerkesztok dalosrezso) (szerkesztok gemesimre) (szerkesztok joszkinede) (szerkesztok paloskata)
    (arak 1500) (arak 1700) (arak 2000) (arak 2200) (arak 2350)
)

(defrule osszes-parositas
    ?day <- (nap ?d)
    ?title <- (cimek ?t)
    ?editor <- (szerkesztok ?e)
    ?price <- (arak ?p)
    =>
    (assert (konyv ?d ?t ?e ?p))
)

    ;1. Sem a hétfőn boltokba került könyvet, sem a Csengő című önéletrajzot nem női szerkesztő dolgozta át. 
    ; hetfoi megjelenesu konyv = szerkezto (nem abafibea es nem paloskata)
(defrule hetfo-nem-noi-szerkeszto
    ?f <- (konyv hetfo ?t ?e ?p) ; le kell menteni mert pattern matching nem mukodik action nel csak a feltetelnel (stackoverflow 10 eve Patterns matching facts are only allowed in the condition portion of a rule, not in the actions of the rule.)
    (or (test (eq ?e abafibea))
        (test (eq ?e paloskata)))
    =>
    (retract ?f) ;
)

    ; csengo cimu konyv = szerkezto (nem abafibea es nem paloskata)
(defrule csengo-nem-noi-szerkeszto
    ?f <- (konyv ?d csengo ?e ?p) 
    (or (test (eq ?e abafibea))
        (test (eq ?e paloskata)))
    =>
    (retract ?f)
)


    ;2. Mind a két előbb említett mű kevesebbe kerül, mint az Abafi Bea által átszerkesztett könyv, ami egy nappal a Joszkin Ede keze munkáját dícsérő kiadvány előtt jelent meg. 
    ; hetfoi konyv ara < abafibea konyv ara
    ; %%%%%%%% NEM JO MERT KITORLI AZ OSSZES HETFOI KONYVET KIVEVE AMI 1500 BA KERUL %%%%%%%%%%%%
(defrule hetfo-ar-abafibea
    ?f1 <- (konyv hetfo ?t ?e ?p) 
    ?f2 <- (konyv ?d ?t2 abafibea ?p2)
    (test (> ?p ?p2))
    =>
    (retract ?f1)
)

    ; csengo konyv ara < abafibea konyv ara
    ; %%%%%%%% SAME MINT FENTI %%%%%%%%%%%%
(defrule csengo-ar-abafibea
    ?f1 <- (konyv ?d csengo ?e ?p)
    ?f2 <- (konyv ?d2 ?t2 abafibea ?p2)
    (test (> ?p ?p2))
    =>
    (retract ?f1)
)


    ;abafi bea konyv -> nap = 1 - joszkinede konyv


    ;3. A Túl Mindenen drágább, mint a Dalos Rezső szerkesztése. 
    ; tulmindenen konyv ara > dalosrezso konyv ara (osszes parositasba, esetleg valahogy szebben?)


    ;4. A Márányfejek-et csütörtök óta lehet kapni. 
    ; csutortok konyv = maranyfejek konyv


    ;5. Az 1700 forintos önéletrajzot Pálos Kata öntötte vésgő formába; ez a mű a már a Márányfejek előtt a boltokban volt. 
    ; 1700 forintos konyv = paloskata szerzo es hetfon vagy kedden jelent meg (szerda nem lehet mert az 1500 ft 6.)

    ;6. A szerdai megjelenésű könyv volt az öt közül a legolcsóbb. 
    ; szerdai konyv =  ara (nem 1700 es nem 2000 es nem 2200 es nem 2350)
(defrule szerdai-konyv-ara
    ?f <- (konyv szerda ?d ?e ?p)
    (or (test (eq ?p 1700))
        (test (eq ?p 2000))
        (test (eq ?p 2200))
        (test (eq ?p 2350)))
    =>
    (retract ?f)
)


    ;7. A Dobos Torta ára 2350 forint. 
    ; dobostorta konyv = ara (nem 1500 es nem 1700 es nem 2000 es nem 2200)
(defrule dobostorta-ar
    ?f <- (konyv ?d dobostorta ?e ?p)
    (or (test (eq ?p 1500))
        (test (eq ?p 1700))
        (test (eq ?p 2000))
        (test (eq ?p 2200)))
    =>
    (retract ?f)
)

    ;8. Gémes Imre a rock-sztár kéziratát szerkesztette át. 
    ; zenebona cimu konyv ) = szerkeszto (nem dalosrezso es nem joszkinede es nem paloskata es nem abafibea)
(defrule gemesimre-zenebona
    ?f <- (konyv ?d zenebona ?e ?p)
    (or (test (eq ?e dalosrezso))
        (test (eq ?e joszkinede))
        (test (eq ?e paloskata)))
        (test (eq ?e abafibea)) 
    =>
    (retract ?f)
)



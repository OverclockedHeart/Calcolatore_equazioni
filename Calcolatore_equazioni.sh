#!/bin/bash

function menu() {

    clear

    echo "Programma scritto da - DANIELE RUOPPOLO"
    echo ""
    echo "Scegli un'operazione da eseguire:"
    echo "1) Risolvi un'equazione di primo grado (ax + b = 0)"
    echo "2) Risolvi un'equazione di secondo grado (ax^2 + bx + c = 0)"
    echo "3) Risolvi un sistema di due equazioni lineari"
    echo "4) Esci"

}

function equazionePrimoGrado() {

    echo "EQUAZIONE DI PRIMO GRADO --> ax + b = 0"
    read -p "Inserisci il valore di a: " a 
    read -p "Inserisci il valore di b: " b 

    clear

    if [[ $a =~ ^-?[0-9]+$ ]] && [[ $b =~ ^-?[0-9]+$ ]]; then #Controllo se si inseriscono solo numeri (ATTENZIONE! la sintassi ^-? ti permette di mettere numeri anche negativi)

        if [ "$a" == "0" ]; then

            if [ "$b" == "0" ]; then #Se sia A che B sono 0, l'equazione ha infinite soluzioni

                echo "L'equazione ha infinite soluzioni"

            else #Se solo A è 0 allora è impossibile

                echo "L'equazione è impossibile"

            fi

        else

            #Risoluzione equazione
            ris=$(echo "scale=2; -($b) / $a" | bc | sed 's/^\./0./; s/^-*\./-0./') #sed e i simboli permettono al programma si non troncare la cifra prima della virgola in caso di risultato float
            echo "La soluzione è: x = $ris"

        fi

    else

        echo "ATTENTO! Devi inserire solo numeri! Niente lettere o simboli"

     fi   

sleep 5
}

function equazioneSecondoGrado() {

    echo "EQUAZIONE DI SECONDO GRADO --> ax^2 + bx + c = 0"

    read -p "Inserisci il valore di a: " a
    read -p "Inserisci il valore di b: " b
    read -p "Inserisci il valore di c: " c

    clear

    if [[ $a =~ ^-?[0-9]+$ ]] && [[ $b =~ ^-?[0-9]+$ ]] && [[ $c =~ ^-?[0-9]+$ ]]; then #Controllo se si inseriscono solo numeri (ATTENZIONE! la sintassi ^-? ti permette di mettere numeri anche negativi)

        if [ "$a" == "0" ]; then #Controllo se A è 0, in caso sia tale allora si richiama la funzione per il calcolo dell'equazione di primo grado

            echo "Se A = 0 allora sarà un'equazione di primo grado!"

            sleep 3

            equazionePrimoGrado

        else

            delta=$(echo "$b^2 - 4*$a*$c" | bc | sed 's/^\./0./; s/^-*\./-0./') #Calcolo DELTA (b^2 - 4ac)

            echo "Il delta è: $delta"

            if [ "$delta" -lt 0 ]; then #Se DELTA è meno di 0 allora l'equazione non ha soluzioni reali (-lt --> less then)

                echo "L'equazione non ha soluzioni reali"
                sleep 2
                clear

                #calcolo situazione con numeri complessi
                parte_reale=$(echo "scale=2; -($b) / (2*$a)" | bc -l | sed 's/^\./0./; s/^-*\./-0./')
                parte_immaginaria=$(echo "scale=2; sqrt(-($delta)) / (2*$a)" | bc -l | sed 's/^\./0./; s/^-*\./-0./')

                echo "x1 = $parte_reale + ${parte_immaginaria}i"
                echo "x2 = $parte_reale - ${parte_immaginaria}i"

                sleep 5

            elif [ "$delta" -eq 0 ]; then #Se DELTA è uguale a 0 allora si ha una soluzione reale doppia (-eq --> equal to)

                ris=$(echo "scale=2; -($b) / (2*($a))" | bc)
                echo "L'equazione ha una soluzione reale doppia: x = $ris"

            else

                #Calcolo dell'equazione con i risultati X1 e X2
                x1=$(echo "scale=2; (-($b) + sqrt($delta)) / (2*$a)" | bc -l | sed 's/^\./0./; s/^-*\./-0./')
                x2=$(echo "scale=2; (-($b) - sqrt($delta)) / (2*$a)" | bc -l | sed 's/^\./0./; s/^-*\./-0./')

                echo "L'equazione ha due soluzioni reali: x1 = $x1 e x2 = $x2"

            fi
        fi

    else

        echo "ATTENTO! Devi inserire solo numeri! Niente lettere o simboli"

     fi   

sleep 5
}

function equazioneLineare(){

    echo "DOPPIA EQUAZIONE LINEARE"

    #Inserimento valori delle due equazioni
    read -p "Inserisci il valore di a1: " a1
    read -p "Inserisci il valore di b1: " b1
    read -p "Inserisci il valore di c1: " c1

    clear

    read -p "Inserisci il valore di a2: " a2
    read -p "Inserisci il valore di b2: " b2
    read -p "Inserisci il valore di c2: " c2

    clear

    if [[ $a1 =~ ^-?[0-9]+$ ]] && [[ $b1 =~ ^-?[0-9]+$ ]] && [[ $c1 =~ ^-?[0-9]+$ ]] && [[ $a2 =~ ^-?[0-9]+$ ]] && [[ $b2 =~ ^-?[0-9]+$ ]] && [[ $c2 =~ ^-?[0-9]+$ ]]; then

        x=$(echo "scale=2; ($c2*$b1) - ($c1*$b2)" | bc)
        y=$(echo "scale=2; ($a2*$c1) - ($a1*$c2)" | bc)

        echo "Il risulto è:"
        echo "X = $x"
        echo "Y = $y"

    else 

        echo "ATTENTO! Devi inserire solo numeri! Niente lettere o simboli"

    fi

sleep 5
}

while true; do

    menu
    read -p "Scegli che tipo di equazione vuoi fare: " operazione

    if [[ $operazione =~ ^-?[0-9]+$ ]]; then #controllo se si inseriscono solo numeri. ATTENZIONE! Il contro si riferisce solo per inserire numeri e non altro

        case $operazione in

            1)
                clear
                equazionePrimoGrado
                ;;

            2)
                clear
                equazioneSecondoGrado
                ;;

            3)       
                clear  
                equazioneLineare
                ;;   

            4)
                clear
                echo "Programma terminato"
                sleep 2

                break
                ;;

            *) #Questa è una forma più compatta e pulita del default, in caso non si mettano i numeri previsti scatta questa eccezione
                clear
                echo "NO! Inserisci un numero tra 1 e 4"
                sleep 2
                ;;

        esac

    else

        clear
        echo "ATTENTO! Devi inserire solo numeri! Niente lettere o simboli"
        sleep 5

    fi
done
